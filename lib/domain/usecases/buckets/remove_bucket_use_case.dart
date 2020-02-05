import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveBucketUseCase extends UseCase<EmptyData, RemoveBucketUseCaseParams> {

  final BucketsRepository repository;

  RemoveBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(RemoveBucketUseCaseParams params) {
    return repository.removeBucket(params.id);
  }

}

class RemoveBucketUseCaseParams extends Equatable {

  final String id;

  RemoveBucketUseCaseParams(this.id) : super([id]);
}