import 'package:cash_box/domain/enteties/tag.dart';
import 'package:cash_box/domain/usecases/tags/get_tags_use_case.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/tag_ids_fixtures.dart';
import 'mock_tags_repository.dart';

void main(){

  final repository = MockTagsRepository();
  final useCase = GetTagsUseCase(repository);

  test("should call the repository to get all tags", () async {
    when(repository.getTags()).thenAnswer((_) async => Right(tagFixtures));

    final result = await useCase(NoParams());

    final tags = result.getOrElse(() => null);
    for(int i = 0; i<tags.length; i++){
      expect(tags.elementAt(i), tagFixtures.elementAt(i));
    }
    verify(repository.getTags());
  });
}