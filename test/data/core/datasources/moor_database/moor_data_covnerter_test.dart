import 'dart:convert';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/buckets_fixtures.dart';
import '../../../../fixtures/field_fixtures.dart';

void main() {
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
}
