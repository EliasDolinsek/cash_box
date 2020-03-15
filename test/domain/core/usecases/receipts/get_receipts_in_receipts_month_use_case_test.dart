import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipt_in_receipt_month_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/receipts_fixtures.dart';
import '../tags/remove_tag_use_case_test.dart';

void main(){

  MockReceiptsRepository repository;
  GetReceiptsInReceiptMonthUseCase useCase;

  setUp((){
    repository = MockReceiptsRepository();
    useCase = GetReceiptsInReceiptMonthUseCase(repository);
  });

  test("should call the repository to return all receipts in a receipt month", () async {
    when(repository.getReceiptsInReceiptMonth(any)).thenAnswer((realInvocation) async => Right(receiptFixtures));

    final receiptMonth = ReceiptMonth(DateTime.now());
    final params = GetReceiptsInReceiptMonthUseCaseParams(receiptMonth);
    final result = await useCase(params);

    expect(result, Right(receiptFixtures));
    verify(repository.getReceiptsInReceiptMonth(receiptMonth)); //Not working because receiptFixtures are lists
  });
}