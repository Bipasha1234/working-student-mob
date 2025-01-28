import 'dart:io';

import 'package:dio/dio.dart';
import 'package:softwarica_student_management_bloc/app/constants/api_endpoints.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/data_source/auth_data_source.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        return token;
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Dio error occurred: ${e.message}');
      }
      throw Exception('An error occurred during login: $e');
    }
  }

  @override
  Future<void> registerStudent(AuthEntity student) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "fname": student.fName,
          "lname": student.lName,
          "phone": student.phone,
          "image": student.image,
          "username": student.username,
          "password": student.password,
          "batch": student.batch.batchId,
          "course": student.courses.map((e) => e.courseId).toList(),
        },
      );

      if (response.statusCode == 201) {
        return; // Registration successful
      } else {
        throw Exception(
            'Failed to register student. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Dio error occurred: ${e.message}');
      }
      throw Exception('An error occurred during registration: $e');
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        final imageUrl = response.data['imageUrl'];
        return imageUrl;
      } else {
        throw Exception(
            'Failed to upload profile picture. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Dio error occurred: ${e.message}');
      }
      throw Exception('An error occurred while uploading profile picture: $e');
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
