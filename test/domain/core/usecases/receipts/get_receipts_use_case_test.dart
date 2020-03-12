import 'package:cash_box/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipts_use_case.dart';
import '../../../../fixtures/receipts_fixtures.dart' as receiptFixtures;
import 'package:mockito/mockito.dart';

class MockReceiptsRepository extends Mock implements ReceiptsRepository {}

void main(){

  MockReceiptsRepository receiptsRepository;
  GetReceiptsUseCase useCase;

  setUp((){
    receiptsRepository = MockReceiptsRepository();
    useCase = GetReceiptsUseCase(receiptsRepository);
  });

  test("usecase", () async {
    when(receiptsRepository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures.receiptFixtures));

    final result = await useCase(NoParams());

    expect(result, Right(receiptFixtures.receiptFixtures));
  });
}