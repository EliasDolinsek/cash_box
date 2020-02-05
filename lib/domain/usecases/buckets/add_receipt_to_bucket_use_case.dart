import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddReceiptToBucketUseCase extends UseCase<EmptyData, AddReceiptUseCaseParams> {

  final BucketsRepository repository;

  AddReceiptToBucketUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddReceiptUseCaseParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}

class AddReceiptUseCaseParams extends Equatable {

  final String bucketID, receiptID;

  AddReceiptUseCaseParams(this.bucketID, this.receiptID) : super([bucketID, receiptID]);

}