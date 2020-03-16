import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveReceiptUseCase extends UseCase<EmptyData, RemoveReceiptUseCaseParams> {

  final ReceiptsRepository repository;

  RemoveReceiptUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(RemoveReceiptUseCaseParams params) {
    return repository.removeReceipt(params.receiptID);
  }
}

class RemoveReceiptUseCaseParams extends Equatable {

  final String receiptID;

  RemoveReceiptUseCaseParams(this.receiptID);

  @override
  List get props => [receiptID];
}