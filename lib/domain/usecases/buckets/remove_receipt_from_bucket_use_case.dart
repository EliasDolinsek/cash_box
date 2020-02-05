import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveReceiptFromBucketUseCase extends UseCase<EmptyData, RemoveReceiptFromBucketUseCaseParams>{

  final BucketsRepository repository;

  RemoveReceiptFromBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(RemoveReceiptFromBucketUseCaseParams params) {
    return repository.removeReceipt(params.bucketID, params.receiptID);
  }

}

class RemoveReceiptFromBucketUseCaseParams extends Equatable {

  final String receiptID, bucketID;

  RemoveReceiptFromBucketUseCaseParams(this.receiptID, this.bucketID) : super([receiptID, bucketID]);
}