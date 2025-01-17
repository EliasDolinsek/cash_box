import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_receipt_to_bucket_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/buckets_fixtures.dart';

class MockBucketsRepository extends Mock implements BucketsRepository {}

void main() {

  MockBucketsRepository repository;
  AddReceiptToBucketUseCase useCase;

  setUp(() {
    repository = MockBucketsRepository();
    useCase = AddReceiptToBucketUseCase(repository);
  });

  test("should call the repostiroy to add a new receipt to a bucket", () async {
    when(repository.getBuckets()).thenAnswer((_) async => Right(bucketFixtures));
    when(repository.updateBucket(any, any)).thenAnswer((_) async => Right(EmptyData()));
    final bucketID = "abc-123";
    final receiptID = "abc-123";

    final params = AddReceiptToBucketUseCaseParams(bucketID, receiptID);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));

    final expectedBucket = bucketFixtures.first..receiptsIDs.add(receiptID);
    verify(repository.updateBucket(bucketID, expectedBucket));
  });
}
