import 'package:cash_box/domain/core/enteties/receipt.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:cash_box/domain/core/usecases/receipts/add_receipt_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/field_fixtures.dart';
import '../../../../fixtures/tag_ids_fixtures.dart';

class MockReceiptsRepository extends Mock implements ReceiptsRepository {}

void main() {
  MockReceiptsRepository repository;
  AddReceiptUseCase useCase;

  setUp(() {
    repository = MockReceiptsRepository();
    useCase = AddReceiptUseCase(repository);
  });

  final receiptToAdd = Receipt("new_receipt",
      type: ReceiptType.outcome,
      creationDate: DateTime.now(),
      fields: fieldFixtures,
      tagIDs: tagIDFixtures);

  test("should call the repository to add new receipt", () async {
    when(repository.addReceipt(any))
        .thenAnswer((_) async => Right(EmptyData()));

    final params = AddReceiptUseCaseParams(receiptToAdd);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.addReceipt(receiptToAdd));
  });

}
