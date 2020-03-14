import 'dart:convert';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/buckets_fixtures.dart';
import '../../../../fixtures/contact_fixtures.dart';
import '../../../../fixtures/field_fixtures.dart';

void main() {

  group("buckets", (){
    test("bucketFromBucketsMoorData", () async {
      final testBucket = bucketFixtures.first;
      final bucketsMoorData = BucketsMoorData(
        id: testBucket.id,
        description: testBucket.description,
        name: testBucket.name,
        receiptsIDs: json.encode(testBucket.receiptsIDs),
      );

      final result = bucketFromBucketsMoorData(bucketsMoorData);
      expect(result, testBucket);
    });

    test("bucketsMoorDataFromBucket", () async {
      final testBucket = bucketFixtures.first;
      final bucketsMoorData = BucketsMoorData(
        id: testBucket.id,
        description: testBucket.description,
        name: testBucket.name,
        receiptsIDs: json.encode(testBucket.receiptsIDs),
      );

      final result = bucketsMoorDataFromBucket(testBucket);
      expect(result, bucketsMoorData);
    });
  });

  group("fields", (){
    test("fieldsMoorDataFromField", () async {
      final field = fieldFixtures.first;
      final result = fieldsMoorDataFromField(field);

      final expectedFieldsMoorData = FieldsMoorData(
        id: field.id,
        description: field.description,
        type: field.type.toString(),
        value: field.value.toString(),
      );

      expect(result, expectedFieldsMoorData);
    });

    test("fieldFromFieldsMoorData", () async {
      final field = fieldFixtures.first;
      final fieldsMoorData = FieldsMoorData(
        id: field.id,
        description: field.description,
        type: field.type.toString(),
        value: field.value.toString(),
      );

      final result = fieldFromFieldsMoorData(fieldsMoorData);
      expect(result, field);
    });
  });

  group("contacts", (){
    test("contactsMoorDataFromContact", () async {
      final contact = contactFixtures.first;
      final result = contactsMoorDataFromContact(contact);

      final fieldIDsList = contact.fields.map((e) => e.id).toList();
      final expectedFieldIDs = json.encode(fieldIDsList);

      final expectedContactsMoorData = ContactsMoorData(id: contact.id, fieldIDs: expectedFieldIDs);
      expect(result, expectedContactsMoorData);
    });

    test("contactFromContactsMoorData", () async {
      final contact = contactFixtures.first;
      final fieldIDsList = contact.fields.map((e) => e.id).toList();
      final contactsMoorData = ContactsMoorData(id: contact.id, fieldIDs: json.encode(fieldIDsList));
      
      final result = contactFromContactsMoorData(contactsMoorData, contact.fields);
      expect(result, contact);
    });
  });
}
