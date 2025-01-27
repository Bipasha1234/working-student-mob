import 'package:dio/dio.dart';
import 'package:softwarica_student_management_bloc/app/constants/api_endpoints.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/batch_data_source.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/dto/get_all_batch_dto.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_api_model.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

class BatchRemoteDataSource implements IBatchDataSource {
  final Dio _dio;

  BatchRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> createBatch(BatchEntity batch) async {
    // TODO: implement createBatch
    try {
      var batchApiModel = BatchApiModel.fromEntity(batch);
      var response = await _dio.post(ApiEndpoints.createBatch,
          data: batchApiModel.toJson());
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBatch(String id) async {
    try {
      var response = await _dio.delete(ApiEndpoints.deleteBatch + id);
      if (response.statusCode != 204) {
        // Assuming 204 No Content for a successful delete
        throw Exception(
            'Failed to delete the batch: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BatchEntity>> getBatches() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllBatch);
      if (response.statusCode == 200) {
        GetAllBatchDTO batchDTO = GetAllBatchDTO.fromJson(response.data);
        return BatchApiModel.toEntityList(batchDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
