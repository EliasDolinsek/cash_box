import 'dart:convert';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/buckets_fixtures.dart';
import '../../../../fixtures/contact_fixtures.dart';
import '../../../../fixtures/field_fixtures.dart';
import '../../../../fixtures/tag_ids_fixtures.dart';
import '../../../../fixtures/templates_fixtures.dart';

void main() {
  group("buckets", () {
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

  group("fields", () {
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

  group("contacts", () {
    test("contactsMoorDataFromContact", () async {
      final contact = contactFixtures.first;
      final result = contactsMoorDataFromContact(contact);

      final fieldIDsList = contact.fields.map((e) => e.id).toList();
      final expectedFieldIDs = json.encode(fieldIDsList);

      final expectedContactsMoorData =
      ContactsMoorData(id: contact.id, fieldIDs: expectedFieldIDs);
      expect(result, expectedContactsMoorData);
    });

    test("contactFromContactsMoorData", () async {
      final contact = contactFixtures.first;
      final fieldIDsList = contact.fields.map((e) => e.id).toList();
      final contactsMoorData =
      ContactsMoorData(id: contact.id, fieldIDs: json.encode(fieldIDsList));

      final result =
      contactFromContactsMoorData(contactsMoorData, contact.fields);
      expect(result, contact);
    });
  });

  group("tags", () {
    test("tagsMoorDataFromTag", () {
      final tag = tagFixtures.first;
      final result = tagsMoorDataFromTag(tag);

      final expectedTagsMoorData =
      TagsMoorData(id: tag.id, name: tag.name, color: tag.color);

      expect(result, expectedTagsMoorData);
    });

    test("tagFromTagsMoorData", () {
      final tag = tagFixtures.first;
      final tagsMoorData =
      TagsMoorData(id: tag.id, name: tag.name, color: tag.color);

      final result = tagFromTagsMoorData(tagsMoorData);
      expect(result, tag);
    });
  });

  group("templates", () {
    test("templatesMoorDataFromTemplate", () async {
      final template = templateFixtures.first;
      final result = templatesMoorDataFromTemplate(template);

      final fieldIDsAsList = template.fields.map((e) => e.id).toList();
      final expectedResult = TemplatesMoorData(
          id: template.id,
          name: template.name,
          fields: json.encode(fieldIDsAsList));

      expect(result, expectedResult);
    });

    test("templateFromTemplatesMoorData", () async {
      final template = templateFixtures.first;
      final templatesMoorData = TemplatesMoorData(
          id: template.id,
          name: template.name,
          fields: null);

      final result = templateFromTemplatesMoorData(templatesMoorData, template.fields);
      expect(result, template);
    });
  });
}
