import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/course_remote_data_source.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/repository/course_repository.dart';

class CourseRemoteRepository implements ICourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  CourseRemoteRepository({required this.courseRemoteDataSource});

  @override
  Future<Either<Failure, void>> createCourse(CourseEntity course) {
    // TODO: implement createCourse
    try {
      courseRemoteDataSource.createCourse(course);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String id) async {
    try {
      await courseRemoteDataSource.deleteCourse(id);
      return Right(unit);
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    try {
      final courses = await courseRemoteDataSource.getCourses();
      return Right(courses);
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString()),
      );
    }
  }
}
