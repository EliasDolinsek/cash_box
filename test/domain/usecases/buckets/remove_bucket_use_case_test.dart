import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/buckets/remove_bucket_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBucketsRepository extends Mock implements BucketsRepository {}

void main(){

  MockBucketsRepository repository;
  RemoveBucketUseCase useCase;

  setUp((){
    repository = MockBucketsRepository();
    useCase = RemoveBucketUseCase(repository);
  });


  test("should call the repository to remove the bucket", () async {
    when(repository.removeBucket(any)).thenAnswer((_) async => Right(EmptyData()));

    final testID = "abc-123";
    final params = RemoveBucketUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.removeBucket(testID));
  });
}