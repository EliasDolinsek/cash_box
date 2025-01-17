import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';
import 'get_bucket_use_case.dart';

class AddReceiptToBucketUseCase extends AsyncUseCase<EmptyData, AddReceiptToBucketUseCaseParams> {

  final BucketsRepository repository;

  AddReceiptToBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddReceiptToBucketUseCaseParams params) async {
    final bucketEither = await getBucket(params.bucketID);
    return bucketEither.fold((failure) => Left(failure), (bucket){
      _addReceiptToBucket(bucket, params.receiptID);
      return repository.updateBucket(params.bucketID, bucket);
    });
  }

  void _addReceiptToBucket(Bucket bucket, String receiptID){
    bucket.receiptsIDs.add(receiptID);
  }

  Future<Either<Failure, Bucket>> getBucket(String id){
    final useCase = GetBucketUseCase(repository);
    final params = GetBucketUseCaseParams(id);
    return useCase(params);
  }

}

class AddReceiptToBucketUseCaseParams extends Equatable {

  final String bucketID, receiptID;

  AddReceiptToBucketUseCaseParams(this.bucketID, this.receiptID) : super([bucketID, receiptID]);

}