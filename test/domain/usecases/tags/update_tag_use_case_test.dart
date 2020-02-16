import 'package:cash_box/domain/enteties/tag.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/tags/update_tag_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/tag_ids_fixtures.dart';
import 'mock_tags_repository.dart';

void main(){

  final repository = MockTagsRepository();
  final useCase = UpdateTagUseCase(repository);

  void _setupRepository(){
    when(repository.getTags()).thenAnswer((_) async => Right(tagFixtures));
    when(repository.updateTag(any, any)).thenAnswer((_) async => Right(EmptyData()));
  }

  final testID = "abc-123";
  final testName = "update";
  final testColor = "green";

  test("should update the tag name", () async {
    _setupRepository();

    final params = UpdateTagUseCaseParams(testID, name: testName);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    final expectedUpdateTag = Tag(testID, name: testName, color: "");
    verify(repository.updateTag(testID, expectedUpdateTag));
  });

  test("should update the tag color", () async {
    _setupRepository();

    final params = UpdateTagUseCaseParams(testID, color: testColor);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    final expectedUpdateTag = Tag(testID, name: "Test", color: testColor);
    verify(repository.updateTag(testID, expectedUpdateTag));
  });
}