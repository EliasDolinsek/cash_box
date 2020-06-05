import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_amount_of_receipts_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import 'filter_receipts_by_type_use_case.dart';

class GetIncomesOutcomesUseCase extends SecureSyncUseCase<
    GetIncomesOutcomesOfBucketUseCaseResult, GetIncomesOutcomesUseCaseParams> {
  final GetAmountOfReceiptsUseCase getAmountOfReceiptsUseCase;
  final FilterReceiptByTypeUseCase filterReceiptByTypeUseCase;

  GetIncomesOutcomesUseCase(
      this.getAmountOfReceiptsUseCase, this.filterReceiptByTypeUseCase);

  @override
  GetIncomesOutcomesOfBucketUseCaseResult call(
      GetIncomesOutcomesUseCaseParams params) {
    final incomeReceipts = filterReceiptByTypeUseCase.call(
      FilterReceiptByTypeUseCaseParams(
          receipts: params.receipts, receiptType: ReceiptType.income),
    );

    final outcomeReceipts = filterReceiptByTypeUseCase.call(
      FilterReceiptByTypeUseCaseParams(
          receipts: params.receipts, receiptType: ReceiptType.outcome),
    );

    final incomeReceiptsAmount = getAmountOfReceiptsUseCase(
        GetAmountOfReceiptsUseCaseParams(incomeReceipts));

    var outcomeReceiptsAmount = getAmountOfReceiptsUseCase(
        GetAmountOfReceiptsUseCaseParams(outcomeReceipts));

    if(outcomeReceiptsAmount < 0){
      outcomeReceiptsAmount *= -1;
    }

    return GetIncomesOutcomesOfBucketUseCaseResult(
      incomeReceipts: incomeReceipts,
      outcomeReceipts: outcomeReceipts,
      incomeReceiptsAmount: incomeReceiptsAmount,
      outcomeReceiptsAmount: outcomeReceiptsAmount
    );
  }
}

class GetIncomesOutcomesOfBucketUseCaseResult extends Equatable {
  final List<Receipt> incomeReceipts, outcomeReceipts;
  final double incomeReceiptsAmount, outcomeReceiptsAmount;

  GetIncomesOutcomesOfBucketUseCaseResult({
    @required this.incomeReceipts,
    @required this.outcomeReceipts,
    @required this.incomeReceiptsAmount,
    @required this.outcomeReceiptsAmount,
  });

  @override
  List get props => [
        incomeReceipts,
        outcomeReceipts,
        incomeReceiptsAmount,
        outcomeReceiptsAmount,
      ];
}

class GetIncomesOutcomesUseCaseParams extends Equatable {
  final List<Receipt> receipts;

  GetIncomesOutcomesUseCaseParams(this.receipts);

  @override
  List get props => [receipts];
}
