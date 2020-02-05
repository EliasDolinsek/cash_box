import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddReceiptToBucketUseCase extends UseCase<EmptyData, AddReceiptToBucketUseCaseParams> {

  final BucketsRepository repository;

  AddReceiptToBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddReceiptToBucketUseCaseParams params) async {
    return repository.addReceipt(params.bucketID, params.receiptID);
  }

}

class AddReceiptToBucketUseCaseParams extends Equatable {

  final String bucketID, receiptID;

  AddReceiptToBucketUseCaseParams(this.bucketID, this.receiptID) : super([bucketID, receiptID]);

}