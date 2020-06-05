import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';

class GetTotalAmountOfReceiptsUseCase extends SecureSyncUseCase<double, List<Receipt>> {
  @override
  double call(List<Receipt> receipts) {
    var totalAmount = 0.0;
    receipts.forEach((element) {
      element.allFieldsNotAsStorageOnly.forEach((element) {
        if(element.type == FieldType.amount) totalAmount += element.value;
      });
    });

    return totalAmount;
  }

}