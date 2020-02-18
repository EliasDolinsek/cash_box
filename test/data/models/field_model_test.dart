import 'package:cash_box/data/models/field_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  final testFieldModel = FieldModel("abc-123", key: "test", description: "test", value: null);

  test("should test if FieldModel extends Field", (){
    expect(testFieldModel, isA<FieldModel>());
  });
}