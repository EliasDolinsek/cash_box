import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

class AddBucketUseCase extends AsyncUseCase<EmptyData, AddBucketUseCaseParams> {

  final BucketsRepository repository;

  AddBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddBucketUseCaseParams params) async {
    return await repository.addBucket(params.bucket);
  }

}

class AddBucketUseCaseParams extends Equatable {

  final Bucket bucket;

  AddBucketUseCaseParams(this.bucket) : super([bucket]);

}