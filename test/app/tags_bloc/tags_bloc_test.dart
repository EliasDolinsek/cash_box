import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/tags/add_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/get_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/get_tags_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/remove_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/update_tag_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/tag_ids_fixtures.dart';

class MockAddTagUseCase extends Mock implements AddTagUseCase {}

class MockGetTagUseCase extends Mock implements GetTagUseCase {}

class MockGetTagsUseCase extends Mock implements GetTagsUseCase {}

class MockRemoveTagUseCase extends Mock implements RemoveTagUseCase {}

class MockUpdateTagUseCase extends Mock implements UpdateTagUseCase {}

void main() {
  final MockAddTagUseCase addTagUseCase = MockAddTagUseCase();
  final MockGetTagUseCase getTagUseCase = MockGetTagUseCase();
  final MockGetTagsUseCase getTagsUseCase = MockGetTagsUseCase();
  final MockRemoveTagUseCase removeTagUseCase = MockRemoveTagUseCase();
  final UpdateTagUseCase updateTagUseCase = MockUpdateTagUseCase();

  TagsBloc bloc;

  setUp(() {
    bloc = TagsBloc(
        addTagUseCase: addTagUseCase,
        getTagUseCase: getTagUseCase,
        getTagsUseCase: getTagsUseCase,
        removeTagUseCase: removeTagUseCase,
        updateTagUseCase: updateTagUseCase);
  });

  test("AddTagEvent", () {
    final tag = tagFixtures.first;
    final params = AddTagUseCaseParams(tag);

    when(getTagsUseCase.call(any)).thenAnswer((_) async => Right(tagFixtures));
    when(addTagUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expect = [TagsLoadingState(), TagsAvailableState(tagFixtures)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = AddTagEvent(tag);
    bloc.dispatch(event);
  });

  test("GetTagEvent", () async {
    final tag = tagFixtures.first;
    final params = GetTagUseCaseParams(tag.id);

    when(getTagUseCase.call(params)).thenAnswer((_) async => Right(tag));

    final expect = [TagsLoadingState(), TagAvailableState(tag)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = GetTagEvent(tag.id);
    bloc.dispatch(event);
  });

  test("GetTagsEvent", () async {
    when(getTagsUseCase.call(any)).thenAnswer((_) async => Right(tagFixtures));

    final expect = [TagsLoadingState(), TagsAvailableState(tagFixtures)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = GetTagsEvent();
    bloc.dispatch(event);
  });

  test("RemoveTagEvent", () async {
    final tag = tagFixtures.first;
    final params = RemoveTagUseCaseParams(tag.id);

    when(getTagsUseCase.call(any)).thenAnswer((_) async => Right(tagFixtures));

    when(removeTagUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expect = [TagsLoadingState(), TagsAvailableState(tagFixtures)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = RemoveTagEvent(tag.id);
    bloc.dispatch(event);
  });

  test("UpdateTagEvent", () async {
    final tag = tagFixtures.first;
    final update = Tag(tag.id, name: "update", color: "update");

    final params =
        UpdateTagUseCaseParams(tag.id, color: update.color, name: update.name);

    when(getTagsUseCase.call(any)).thenAnswer((_) async => Right(tagFixtures));

    when(updateTagUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expect = [TagsLoadingState(), TagsAvailableState(tagFixtures)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event =
        UpdateTagEvent(tag.id, name: update.name, color: update.color);
    bloc.dispatch(event);
  });
}
