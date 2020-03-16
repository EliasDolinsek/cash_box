import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/receipts/remove_receipt_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../tags/remove_tag_use_case_test.dart';

void main(){

  MockReceiptsRepository receiptRepository;
  RemoveReceiptUseCase useCase;

  setUp(() async {
    receiptRepository = MockReceiptsRepository();
    useCase = RemoveReceiptUseCase(receiptRepository);
  });

  test("should call the repository to remove a receipt", () async {
    final testID = "abc-123";
    when(receiptRepository.removeReceipt(any)).thenAnswer((_) async => Right(EmptyData()));

    final params = RemoveReceiptUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
  });
}