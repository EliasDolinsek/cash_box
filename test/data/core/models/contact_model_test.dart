import 'package:cash_box/data/core/models/contact_model.dart';
import 'package:cash_box/domain/core/enteties/contact.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/field_fixtures.dart';

void main() {
  final testContactModel = ContactModel("abc-123", fields: fieldFixtures);

  test("should test if ContactModel extends Contact", () {
    expect(testContactModel, isA<Contact>());
  });

  test("toMap", () {
    final testContactModel = ContactModel("abc-123", fields: fieldFixtures);
    final expectedMap = {
      "id": "abc-123",
      "fields": [
        {
          "id": "abc-123",
          "type": "amount",
          "description": "description1",
          "value": 12.5
        },
        {
          "id": "def-456",
          "type": "text",
          "description": "description2",
          "value": "value2"
        },
        {
          "id": "ghi-789",
          "type": "date",
          "description": "description3",
          "value": 1582299252124
        }
      ]
    };

    final result = testContactModel.toMap();
    expect(result, expectedMap);
  });

  test("fromMap", (){
    final testMap = {
      "id": "abc-123",
      "fields": [
        {
          "id": "abc-123",
          "type": "amount",
          "description": "description1",
          "value": 12.5
        },
        {
          "id": "def-456",
          "type": "text",
          "description": "description2",
          "value": "value2"
        },
        {
          "id": "ghi-789",
          "type": "date",
          "description": "description3",
          "value": 1582299252124
        }
      ]
    };

    final result = ContactModel.fromMap(testMap);
    expect(result.toMap(), testMap);
  });
}
