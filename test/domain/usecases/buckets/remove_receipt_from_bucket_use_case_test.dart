import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/buckets/remove_receipt_from_bucket_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/buckets_fixtures.dart';

class MockBucketsRepository extends Mock implements BucketsRepository {}

void main(){


  MockBucketsRepository repository;
  RemoveReceiptFromBucketUseCase useCase;

  setUp((){
    repository = MockBucketsRepository();
    useCase = RemoveReceiptFromBucketUseCase(repository);
  });

  test("should call the repository to remove the receipt from the bucket", () async {
    when(repository.getBuckets()).thenAnswer((_) async => Right(bucketFixtures));
    when(repository.updateBucket(any, any)).thenAnswer((_) async => Right(EmptyData()));

    final testReceiptID = "abc-123", testBucketID = "abc-123";
    final params = RemoveReceiptFromBucketUseCaseParams(testReceiptID, testBucketID);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));

    final expectedBucket = bucketFixtures.first..receiptsIDs.remove(testReceiptID);
    verify(repository.updateBucket(testBucketID, expectedBucket));
  });
}