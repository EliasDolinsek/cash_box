import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'get_bucket_use_case.dart';

class RemoveReceiptFromBucketUseCase extends UseCase<EmptyData, RemoveReceiptFromBucketUseCaseParams>{

  final BucketsRepository repository;

  RemoveReceiptFromBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(RemoveReceiptFromBucketUseCaseParams params) async {
    final bucketEither = await getBucket(params.bucketID);
    return bucketEither.fold((failure) => Left(failure), (bucket){
      _removeReceiptToBucket(bucket, params.receiptID);
      return repository.updateBucket(params.bucketID, bucket);
    });
  }

  void _removeReceiptToBucket(Bucket bucket, String receiptID){
    bucket.receiptsIDs.remove(receiptID);
  }

  Future<Either<Failure, Bucket>> getBucket(String id){
    final useCase = GetBucketUseCase(repository);
    final params = GetBucketUseCaseParams(id);
    return useCase(params);
  }

}

class RemoveReceiptFromBucketUseCaseParams extends Equatable {

  final String receiptID, bucketID;

  RemoveReceiptFromBucketUseCaseParams(this.receiptID, this.bucketID) : super([receiptID, bucketID]);
}