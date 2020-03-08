import 'package:cash_box/domain/core/enteties/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/buckets/update_bucket_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/buckets_fixtures.dart';

class MockBucketsRepository extends Mock implements BucketsRepository {}

void main() {
  MockBucketsRepository repository;
  UpdateBucketUseCase useCase;

  void _setupRepositoryUpdateBucket() {
    when(repository.updateBucket(any, any))
        .thenAnswer((_) async => Right(EmptyData()));
  }

  setUp(() {
    repository = MockBucketsRepository();
    useCase = UpdateBucketUseCase(repository);
  });

  test("should update the bucket name", () async {
    final testName = "update", testID = "abc-123";
    _setupRepositoryUpdateBucket();
    when(repository.getBuckets())
        .thenAnswer((_) async => Right(bucketFixtures));

    final params = UpdateBucketUseCaseParams(testID, name: testName);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));

    final originalBucket = bucketFixtures.firstWhere((b) => b.id == testID);
    final expectedBucket = Bucket(testID,
        name: testName,
        description: originalBucket.description,
        receiptsIDs: originalBucket.receiptsIDs);
    verify(repository.updateBucket(testID, expectedBucket));
  });

  test("should update the bucket description", () async {
    final testDescription = "update", testID = "abc-123";
    _setupRepositoryUpdateBucket();
    when(repository.getBuckets())
        .thenAnswer((_) async => Right(bucketFixtures));

    final params = UpdateBucketUseCaseParams(testID, description: testDescription);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));

    final originalBucket = bucketFixtures.firstWhere((b) => b.id == testID);
    final expectedBucket = Bucket(testID,
        name: originalBucket.name,
        description: testDescription,
        receiptsIDs: originalBucket.receiptsIDs);
    verify(repository.updateBucket(testID, expectedBucket));
  });

  test("should update the receiptIDs", () async {
    final testReceiptIDs = ["abc-123"], testID = "abc-123";
    _setupRepositoryUpdateBucket();
    when(repository.getBuckets())
        .thenAnswer((_) async => Right(bucketFixtures));

    final params = UpdateBucketUseCaseParams(testID, receiptIDs: testReceiptIDs);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));

    final originalBucket = bucketFixtures.firstWhere((b) => b.id == testID);
    final expectedBucket = Bucket(testID,
        name: originalBucket.name,
        description: originalBucket.description,
        receiptsIDs: testReceiptIDs);
    verify(repository.updateBucket(testID, expectedBucket));
  });
}
