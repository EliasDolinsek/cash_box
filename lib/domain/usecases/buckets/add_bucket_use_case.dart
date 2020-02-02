import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddBucketUseCase extends UseCase<EmptyData, AddBucketUseCaseParams> {

  final BucketsRepository repository;

  AddBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddBucketUseCaseParams params) {
    return repository.addBucket(params.bucket);
  }

}

class AddBucketUseCaseParams extends Equatable {

  final Bucket bucket;

  AddBucketUseCaseParams(this.bucket) : super([bucket]);

}