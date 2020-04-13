import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/domain/core/usecases/receipts/filter_receipts_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/receipts_fixtures.dart';
import '../tags/remove_tag_use_case_test.dart';

void main() {
  MockReceiptsRepository repository;
  FilterReceiptsUseCase useCase;

  setUp(() {
    repository = MockReceiptsRepository();
    useCase = FilterReceiptsUseCase(repository);
  });

  test("should get all receipts if the receiptMonth is null", () async {
    when(repository.getReceipts())
        .thenAnswer((realInvocation) async => Right(receiptFixtures));
    final params = FilterReceiptsUseCaseParams(receiptMonth: null);

    final result = await useCase(params);
    expect(result, Right(receiptFixtures));
  });

  test("should get all receipts if the receiptMonth is not null", () async {
    final testReceiptMonth = ReceiptMonth(DateTime.now());

    when(repository.getReceiptsInReceiptMonth(testReceiptMonth))
        .thenAnswer((realInvocation) async => Right(receiptFixtures));
    final params = FilterReceiptsUseCaseParams(receiptMonth: testReceiptMonth);

    final result = await useCase(params);
    expect(result, Right(receiptFixtures));
  });

  group("filtering", () {
    final testReceipts = [
      Receipt.newReceipt(
        type: ReceiptType.income,
        creationDate: DateTime.now(),
        fields: [
          Field.newField(
              type: FieldType.text,
              description: "description",
              value: "description1")
        ],
        tagIDs: ["111"],
      ),
      Receipt.newReceipt(
        type: ReceiptType.outcome,
        creationDate: DateTime.now(),
        fields: [
          Field.newField(
              type: FieldType.text,
              description: "description",
              value: "description2")
        ],
        tagIDs: ["123"],
      )
    ];

    test("should filter all receipts by text", () async {
      final testText = "description1";
      when(repository.getReceipts())
          .thenAnswer((realInvocation) async => Right(testReceipts));

      final params = FilterReceiptsUseCaseParams(text: testText);
      final result = await useCase(params);

      expect(result, Right(testReceipts));
    });

    test("should filter all receipts by tags", () async {
      final testTagIds = ["123"];
      when(repository.getReceipts())
          .thenAnswer((realInvocation) async => Right(testReceipts));

      final params = FilterReceiptsUseCaseParams(tagIds: testTagIds);
      final result = await useCase(params);

      expect(result, Right(testReceipts));
    });
  });
}
