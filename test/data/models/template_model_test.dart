import 'package:cash_box/domain/enteties/template.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/field_fixtures.dart';

void main(){

  final testTemplate = Template("abc-123", name: "name", fields: fieldFixtures);

  test("should test if TemplateModel extends Template", (){
    expect(testTemplate, isA<Template>());
  });
}