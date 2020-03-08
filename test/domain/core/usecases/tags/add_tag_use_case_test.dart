import 'package:cash_box/domain/core/enteties/tag.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/tags/add_tag_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_tags_repository.dart';

void main(){

  final repository = MockTagsRepository();
  final useCase = AddTagUseCase(repository);

  test("should call the repository to add a new tag", () async {
    when(repository.addTag(any)).thenAnswer((_) async => Right(EmptyData()));

    final testTag = Tag("test-123", name: "Test", color: "abcdef");
    final params = AddTagUseCaseParams(testTag);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.addTag(testTag));
  });
}