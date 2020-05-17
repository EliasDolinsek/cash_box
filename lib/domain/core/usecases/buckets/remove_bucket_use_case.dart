import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

class RemoveBucketUseCase extends AsyncUseCase<EmptyData, RemoveBucketUseCaseParams> {

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