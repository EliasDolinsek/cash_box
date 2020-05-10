import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAmountOfReceiptsUseCase extends UseCase<double, GetAmountOfReceiptsUseCaseParams> {

  @override
  Future<Either<Failure, double>> call(GetAmountOfReceiptsUseCaseParams params) async {
    var amount = 0.0;

    params.receipts.forEach((receipt) {
      receipt.allFieldsNotAsStorageOnly.forEach((field) {
        if(field.type == FieldType.amount){
          if(receipt.type == ReceiptType.income){
            amount += field.value;
          } else {
            amount -= field.value;
          }
        }
      });
    });

    return Right(amount);
  }

}

class GetAmountOfReceiptsUseCaseParams extends Equatable{

  final List<Receipt> receipts;

  GetAmountOfReceiptsUseCaseParams(this.receipts);

  @override
  List get props => [receipts];
}