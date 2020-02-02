import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetReceiptUseCase extends UseCase<Receipt, GetReceiptUseCaseParams> {

  final ReceiptsRepository repository;

  GetReceiptUseCase(this.repository);

  @override
  Future<Either<Failure, Receipt>> call(GetReceiptUseCaseParams params) async {
    final receipts = await repository.getReceipts();
    return receipts.fold((failure) async {
      return Left(failure);
    }, (receiptsList) {
      final receipt = _getReceiptById(params.id, receiptsList);
      if(receipt == null){
        return Left(ReceiptNotFoundFailure());
      } else {
        return Right(receipt);
      }
    });
  }

  Receipt _getReceiptById(String id, List<Receipt> receipts){
    return receipts.firstWhere((receipt) => receipt.id == id, orElse: () => null);
  }

}

class GetReceiptUseCaseParams extends Equatable {

  final String id;

  GetReceiptUseCaseParams(this.id) : super([id]);
}