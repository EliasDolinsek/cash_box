import 'package:cash_box/data/models/contact_model.dart';
import 'package:cash_box/domain/enteties/contact.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/field_fixtures.dart';

void main(){

  final testContactModel = ContactModel("abc-123", fields: fieldFixtures);

  test("should test if ContactModel extends Contact", (){
    expect(testContactModel, isA<Contact>());
  });
}