import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_amount_of_receipts_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

class GetIncomesOutcomesOfBucketUseCase
    extends UseCase<GetIncomesOutcomesOfBucketUseCaseResult, GetIncomesOutcomesOfBucketUseCaseParams> {
  final GetAmountOfReceiptsUseCase getAmountOfReceiptsUseCase;

  GetIncomesOutcomesOfBucketUseCase(this.getAmountOfReceiptsUseCase);

  @override
  Future<Either<Failure, GetIncomesOutcomesOfBucketUseCaseResult>> call(
      GetIncomesOutcomesOfBucketUseCaseParams params) async {
    final incomeReceipts = params.receipts
        .where((element) => element.type == ReceiptType.income)
        .toList();
    final outcomeReceipts = params.receipts
        .where((element) => element.type == ReceiptType.outcome)
        .toList();

    final incomeReceiptsAmountResult = await getAmountOfReceiptsUseCase(
        GetAmountOfReceiptsUseCaseParams(incomeReceipts));
    final outcomeReceiptsAmountResult = await getAmountOfReceiptsUseCase(
        GetAmountOfReceiptsUseCaseParams(incomeReceipts));

    var incomeReceiptsAmount, outcomeReceiptsAmount;
    incomeReceiptsAmountResult.fold((l) {
      incomeReceiptsAmount = l;
    }, (r) {
      incomeReceiptsAmount = r;
    });

    outcomeReceiptsAmountResult.fold((l) {
      outcomeReceiptsAmount = l;
    }, (r) {
      outcomeReceiptsAmount = r;
    });

    if (incomeReceiptsAmount is Failure) {
      return Left(incomeReceiptsAmount);
    }

    if (outcomeReceiptsAmount is Failure) {
      return Left(incomeReceiptsAmount);
    }

    final result = GetIncomesOutcomesOfBucketUseCaseResult(
        incomeReceipts: incomeReceipts,
        incomeReceiptsAmount: incomeReceiptsAmount,
        outcomeReceipts: outcomeReceipts,
        outcomeReceiptsAmount: outcomeReceiptsAmount);

    return Right(result);
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

class GetIncomesOutcomesOfBucketUseCaseParams extends Equatable {
  final Bucket bucket;
  final List<Receipt> receipts;

  GetIncomesOutcomesOfBucketUseCaseParams(this.bucket, this.receipts);

  @override
  List get props => [bucket, receipts];
}
