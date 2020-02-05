import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/usecases/receipts/add_receipt_use_case.dart';
import 'package:cash_box/domain/usecases/templates/add_template_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/field_fixtures.dart';
import '../../../fixtures/tag_ids_fixtures.dart';

class MockReceiptsRepository extends Mock implements ReceiptsRepository {}

void main() {
  MockReceiptsRepository repository;
  AddReceiptUseCase useCase;

  setUp(() {
    repository = MockReceiptsRepository();
    useCase = AddReceiptUseCase(repository);
  });

  final receiptToAdd = Receipt("new_receipt",
      type: ReceiptType.OUTCOME,
      creationDate: DateTime.now(),
      fields: fieldFixtures,
      tagIDs: tagFixtures);

  test("should call the repository to add new receipt", () async {
    when(repository.addReceipt(any))
        .thenAnswer((_) async => Right(EmptyData()));

    final params = AddReceiptUseCaseParams(receiptToAdd);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.addReceipt(receiptToAdd));
  });

}
