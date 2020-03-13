import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/use_case.dart';
import 'get_bucket_use_case.dart';

class UpdateBucketUseCase
    extends UseCase<EmptyData, UpdateBucketUseCaseParams> {
  final BucketsRepository repository;

  UpdateBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(
      UpdateBucketUseCaseParams params) async {
    final bucketEither = await _getBucketForID(params.id);
    return bucketEither.fold((failure) => Left(failure), (originalBucket) {
      final updatedBucket = _getUpdatedBucket(params, originalBucket);
      return repository.updateBucket(params.id, updatedBucket);
    });
  }

  Future<Either<Failure, Bucket>> _getBucketForID(String id) async {
    final params = GetBucketUseCaseParams(id);
    final useCase = GetBucketUseCase(repository);
    return await useCase(params);
  }

  Bucket _getUpdatedBucket(UpdateBucketUseCaseParams params, Bucket original) {
    return Bucket(original.id,
        name: params.name ?? original.name,
        description: params.description ?? original.description,
        receiptsIDs: params.receiptIDs ?? original.receiptsIDs);
  }
}

class UpdateBucketUseCaseParams extends Equatable {
  final String id;
  final String name, description;
  final List<String> receiptIDs;

  UpdateBucketUseCaseParams(this.id,
      {this.name, this.description, this.receiptIDs})
      : super([name, description, receiptIDs]);
}
