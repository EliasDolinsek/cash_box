import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddReceiptUseCase extends UseCase<EmptyData, AddReceiptUseCaseParams> {

  final ReceiptsRepository repository;

  AddReceiptUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddReceiptUseCaseParams params) {
    return repository.addReceipt(params.receipt);
  }

}

class AddReceiptUseCaseParams extends Equatable {

  final Receipt receipt;

  AddReceiptUseCaseParams(this.receipt) : super([receipt]);
}