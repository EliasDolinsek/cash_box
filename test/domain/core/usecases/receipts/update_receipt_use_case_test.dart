import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/receipt.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:cash_box/domain/core/usecases/receipts/update_receipt_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/field_fixtures.dart';
import '../../../../fixtures/receipts_fixtures.dart';
import '../../../../fixtures/tag_ids_fixtures.dart';

class MockReceiptsRepository extends Mock implements ReceiptsRepository {}

void main() {
  MockReceiptsRepository repository;
  UpdateReceiptUseCase useCase;

  setUp(() {
    repository = MockReceiptsRepository();
    useCase = UpdateReceiptUseCase(repository);
  });

  final testID = "abc-123";
  final testFailureID = "not_found";

  group("successful tests", () {
    test("should update the receipt type", () async {
      when(repository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures));
      when(repository.updateReceipt(testID, any))
          .thenAnswer((_) async => Right(EmptyData()));

      final params = UpdateReceiptUseCaseParams(testID, type: ReceiptType.INVESTMENT);
      final result = await useCase(params);

      expect(result, Right(EmptyData()));
      final originalReceipt = receiptFixtures.firstWhere((r) => r.id == testID);
      final expectedUpdateReceipt = Receipt(
          testID, type: ReceiptType.INVESTMENT,
          tagIDs: originalReceipt
              .tagIDs,
          creationDate: originalReceipt.creationDate,
          fields: originalReceipt.fields);

      verify(repository.updateReceipt(testID, expectedUpdateReceipt));
    });

    test("should update the receipt fields", () async {
      when(repository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures));
      when(repository.updateReceipt(testID, any))
          .thenAnswer((_) async => Right(EmptyData()));

      final newFields = fieldFixtures..removeLast();
      final params = UpdateReceiptUseCaseParams(testID, fields: newFields);
      final result = await useCase(params);

      expect(result, Right(EmptyData()));
      final originalReceipt = receiptFixtures.firstWhere((r) => r.id == testID);
      final expectedUpdateReceipt = Receipt(
          testID, type: originalReceipt.type,
          tagIDs: originalReceipt
              .tagIDs,
          creationDate: originalReceipt.creationDate,
          fields: newFields);

      verify(repository.updateReceipt(testID, expectedUpdateReceipt));
    });

    test("should update the receipt tagIDs", () async {
      when(repository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures));
      when(repository.updateReceipt(testID, any))
          .thenAnswer((_) async => Right(EmptyData()));

      final newTagIDs = tagIDFixtures..removeLast();
      final params = UpdateReceiptUseCaseParams(testID, tagIDs: newTagIDs);
      final result = await useCase(params);

      expect(result, Right(EmptyData()));
      final originalReceipt = receiptFixtures.firstWhere((r) => r.id == testID);
      final expectedUpdateReceipt = Receipt(
          testID, type: originalReceipt.type,
          tagIDs: newTagIDs,
          creationDate: originalReceipt.creationDate,
          fields: originalReceipt.fields);

      verify(repository.updateReceipt(testID, expectedUpdateReceipt));
    });
  });

  group("failure tests", () {
    test("should return a ReceiptNotFoundFailure if the given receipt-id doesn't exist", () async {
      when(repository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures));
      final result = await useCase(UpdateReceiptUseCaseParams(testFailureID));

      expect(result, Left(ReceiptNotFoundFailure()));
    });
  });
}
