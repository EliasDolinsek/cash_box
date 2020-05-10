import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/usecases/buckets/get_buckets_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/buckets_fixtures.dart';

class MockBucketsRepository extends Mock implements BucketsRepository {}

void main(){

  MockBucketsRepository repository;
  GetBucketsUseCase useCase;

  setUp((){
    repository = MockBucketsRepository();
    useCase = GetBucketsUseCase(repository);
  });

  test("should get all buckets from the repository", () async {
    when(repository.getBuckets()).thenAnswer((_) async => Right(bucketFixtures));

    final result = await useCase(NoParams());

    expect(result, Right(bucketFixtures));
  });
}