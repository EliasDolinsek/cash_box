import 'package:cash_box/data/models/field_model.dart';
import 'package:cash_box/data/models/template_model.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/field_fixtures.dart';

void main(){

  final testTemplate = TemplateModel("abc-123", name: "name", fields: fieldFixtures.map((field) => FieldModel.fromField(field)).toList());

  test("should test if TemplateModel extends Template", (){
    expect(testTemplate, isA<Template>());
  });

  test("toMap and fromMap", (){
    final map = testTemplate.toMap();
    final templateModelFromMap = TemplateModel.fromMap(map);
    expect(templateModelFromMap, testTemplate);
  });
}