import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/usecases/receipts/remove_receipt_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/receipts_fixtures.dart' as receiptFixtures;

class MockReceiptsRepository extends Mock implements ReceiptsRepository {}

void main(){

  MockReceiptsRepository repository;
  RemoveReceiptUseCase useCase;

  setUp((){
    repository = MockReceiptsRepository();
    useCase = RemoveReceiptUseCase(repository);
  });

  final testID = "abc-123";
  test("should call the repository to remove the receipt", () async {
    when(repository.removeReceipt(testID)).thenAnswer((_) async => Right(EmptyData()));
    when(repository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures.receiptFixtures));
    final params = RemoveReceiptUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.removeReceipt(testID));
  });
}