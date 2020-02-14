import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/usecases/tags/remove_tag_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/receipts_fixtures.dart';
import 'mock_tags_repository.dart';

class MockReceiptsRepository extends Mock implements ReceiptsRepository {}

void main(){

  final tagsRepository = MockTagsRepository();
  final receiptsRepository = MockReceiptsRepository();

  final useCase = RemoveTagUseCase(tagsRepository, receiptsRepository);

  test("should call the repository to remove a tag and remove it from all receipts", () async {
    when(tagsRepository.removeTag(any)).thenAnswer((_) async => Right(EmptyData()));
    when(receiptsRepository.getReceipts()).thenAnswer((_) async => Right(receiptFixtures));

    final testID = "abc-123";
    final params = RemoveTagUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(tagsRepository.removeTag(testID));

    receiptFixtures.forEach((receipt){
      receipt.tagIDs.remove(testID);
      verify(receiptsRepository.updateReceipt(receipt.id, receipt));
    });
  });
}