import 'package:cash_box/domain/core/enteties/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_bucket_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/buckets_fixtures.dart';

class MockBucketsRepository extends Mock implements BucketsRepository {}

void main() {
  MockBucketsRepository repository;
  AddBucketUseCase useCase;

  setUp(() {
    repository = MockBucketsRepository();
    useCase = AddBucketUseCase(repository);
  });

  test("should call the repository to add a new bucket", () async {
    when(repository.addBucket(any)).thenAnswer((_) async => Right(EmptyData()));

    final bucketToAdd = Bucket("jkl-10112", name: "Test4",
        description: "Description3",
        receiptsIDs: defaultReceiptIDFixtures);
    final params = AddBucketUseCaseParams(bucketToAdd);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.addBucket(bucketToAdd));
  });
}