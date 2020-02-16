import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/usecases/tags/get_tag_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/tag_ids_fixtures.dart';
import 'mock_tags_repository.dart';

void main(){

  final repository = MockTagsRepository();
  final useCase = GetTagUseCase(repository);

  test("should get all tags useing the repository and then filter for the searched one", () async {
    when(repository.getTags()).thenAnswer((_) async => Right(tagFixtures));

    final testID = "abc-123";
    final params = GetTagUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(tagFixtures.first));
    verify(repository.getTags());
  });

  test("should return TagNotFoundFailure if the searched tag doesn't exist", () async {
    when(repository.getTags()).thenAnswer((_) async => Right(tagFixtures));

    final testID = "not_found";
    final params = GetTagUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Left(TagNotFoundFailure()));
    verify(repository.getTags());
  });

}