import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipt_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/receipts_fixtures.dart';

class MockReceiptsRepository extends Mock implements ReceiptsRepository {}

void main(){
  MockReceiptsRepository repository;
  GetReceiptUseCase useCase;

  setUp((){
    repository = MockReceiptsRepository();
    useCase = GetReceiptUseCase(repository);
  });

  final testID = "abc-123";
  final notFoundTestID = "not_found";

  test("get receipt by id", () async {
    when(repository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures));

    final params = GetReceiptUseCaseParams(testID);
    final result = await useCase(params);

    final expectedResultReceipt = receiptFixtures.firstWhere((e) => e.id == testID);
    expect(result, Right(expectedResultReceipt));
  });

  test("should return a ReceiptNotFoundFailure if the given receipt id doesn't exist", () async {
    when(repository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures));

    final params = GetReceiptUseCaseParams(notFoundTestID);
    final result = await useCase(params);

    expect(result, Left(ReceiptNotFoundFailure()));
  });
}