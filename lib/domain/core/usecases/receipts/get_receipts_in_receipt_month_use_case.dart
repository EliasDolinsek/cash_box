import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetReceiptsInReceiptMonthUseCase extends AsyncUseCase<List<Receipt>,
    GetReceiptsInReceiptMonthUseCaseParams> {
  final ReceiptsRepository repository;

  GetReceiptsInReceiptMonthUseCase(this.repository);

  @override
  Future<Either<Failure, List<Receipt>>> call(
      GetReceiptsInReceiptMonthUseCaseParams params) {
    return repository.getReceiptsInReceiptMonth(params.asReceiptMonth);
  }
}

class GetReceiptsInReceiptMonthUseCaseParams extends Equatable {

  final DateTime month;

  GetReceiptsInReceiptMonthUseCaseParams(this.month);

  ReceiptMonth get asReceiptMonth => ReceiptMonth(month);

  @override
  List get props => [month];
}
