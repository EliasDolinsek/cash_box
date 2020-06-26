import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:equatable/equatable.dart';

class GetAmountOfReceiptsUseCase
    extends SecureSyncUseCase<double, GetAmountOfReceiptsUseCaseParams> {
  @override
  double call(GetAmountOfReceiptsUseCaseParams params) {
    var amount = 0.0;

    params.receipts.forEach((receipt) {
      receipt.allFieldsNotAsStorageOnly.forEach((field) {
        if (field.type == FieldType.amount && field.value != null) {
          if (receipt.type == ReceiptType.income) {
            amount += field.value;
          } else {
            amount -= field.value;
          }
        }
      });
    });

    return amount;
  }
}

class GetAmountOfReceiptsUseCaseParams extends Equatable {
  final List<Receipt> receipts;

  GetAmountOfReceiptsUseCaseParams(this.receipts);

  @override
  List get props => [receipts];
}
