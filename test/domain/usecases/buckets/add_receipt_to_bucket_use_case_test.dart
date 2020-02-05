import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/buckets/add_receipt_to_bucket_use_case.dart';
import 'package:cash_box/domain/usecases/receipts/add_receipt_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/field_fixtures.dart';
import '../../../fixtures/tag_ids_fixtures.dart';
import 'add_bucket_use_case_test.dart';

class MockBucketsRepository extends Mock implements BucketsRepository {}

void main() {
  MockBucketsRepository repository;
  AddReceiptUseCase useCase;

  setUp(() {
    repository = MockBucketsRepository();
    useCase = AddReceiptUseCase(repository);
  });

  test("should call the repostiroy to add a new receipt to a bucket", () async {
    final bucketID = "abc-123";
    final receiptToAdd = Receipt("abc-123",
        type: ReceiptType.OUTCOME,
        creationDate: DateTime.now(),
        fields: fieldFixtures,
        tagIDs: tagFixtures);
    when(repository.addBucket(any)).thenAnswer((_) async => Right(EmptyData()));

    final params = AddReceiptUseCaseParams(bucketID, receiptToAdd);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.addReceipt(bucketID, receiptToAdd));
  });
}
