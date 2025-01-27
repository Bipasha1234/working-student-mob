import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/batch_remote_data_source.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class BatchRemoteRepository implements IBatchRepository {
  final BatchRemoteDataSource batchRemoteDataSource;

  BatchRemoteRepository({required this.batchRemoteDataSource});

  @override
  Future<Either<Failure, void>> createBatch(BatchEntity batch) async {
    // TODO: implement createBatch
    try {
      batchRemoteDataSource.createBatch(batch);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) async {
    try {
      await batchRemoteDataSource.deleteBatch(id);
      return Right(unit);
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getBatches() async {
    try {
      final batches = await batchRemoteDataSource.getBatches();
      return Right(batches);
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString()),
      );
    }
  }
}
