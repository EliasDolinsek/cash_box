import 'package:cash_box/data/core/models/field_model.dart';
import 'package:cash_box/data/core/models/receipt_model.dart';
import 'package:cash_box/domain/core/enteties/receipt.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/field_fixtures.dart';

void main(){

  final testFieldFixtures = fieldFixtures.map((field) => FieldModel.fromField(field)).toList();
  final testReceiptModel = ReceiptModel("abc-123", type: ReceiptType.OUTCOME, creationDate: DateTime.now(), fields: testFieldFixtures, tagIDs: ["abc-123", "def-456"]);

  test("should test if ReceiptModel extends Receipt", (){
    expect(testReceiptModel, isA<Receipt>());
  });

  test("parsing fromMap and converting toMap", (){
    final toMapResult = testReceiptModel.toMap();
    final fromMapResult = ReceiptModel.fromMap(toMapResult);
    expect(fromMapResult, testReceiptModel);
  });
}