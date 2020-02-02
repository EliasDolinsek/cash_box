import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/usecases/buckets/get_bucket_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/buckets_fixtures.dart';

class MockBucketsRepository extends Mock implements BucketsRepository {}

void main(){

  MockBucketsRepository repository;
  GetBucketUseCase useCase;

  setUp((){
    repository = MockBucketsRepository();
    useCase = GetBucketUseCase(repository);
  });

  final testID = "abc-123";
  final testFailureID = "not_found";

  test("should return the bucket with the same id", () async {
    when(repository.getBuckets()).thenAnswer((_) async => Right(bucketFixtures));

    final params = GetBucketUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(bucketFixtures.first));
  });

  test("should return a BucketNotFoundFailure if the bucket-id doesn't exist", () async {
    when(repository.getBuckets()).thenAnswer((_) async => Right(bucketFixtures));

    final params = GetBucketUseCaseParams(testFailureID);
    final result = await useCase(params);

    expect(result, Left(BucketNotFoundFailure()));
  });
}