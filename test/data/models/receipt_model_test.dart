import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  final testReceiptModel = Receipt("abc-123", type: ReceiptType.OUTCOME, creationDate: DateTime.now(), fields: null, tagIDs: null);

  test("should test if ReceiptModel extends Receipt", (){
    expect(testReceiptModel, isA<Receipt>());
  });
}