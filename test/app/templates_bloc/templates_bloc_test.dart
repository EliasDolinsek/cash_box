import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/templates/add_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/get_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/get_templates_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/remove_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/update_template_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/templates_fixtures.dart';

class MockAddTemplateUseCase extends Mock implements AddTemplateUseCase {}

class MockGetTemplateUseCase extends Mock implements GetTemplateUseCase {}

class MockGetTemplatesUseCase extends Mock implements GetTemplatesUseCase {}

class MockRemoveTemplateUseCase extends Mock implements RemoveTemplateUseCase {}

class MockUpdateTemplateUseCase extends Mock implements UpdateTemplateUseCase {}

void main() {
  final MockAddTemplateUseCase addTemplateUseCase = MockAddTemplateUseCase();
  final MockGetTemplateUseCase getTemplateUseCase = MockGetTemplateUseCase();
  final MockGetTemplatesUseCase getTemplatesUseCase = MockGetTemplatesUseCase();
  final MockRemoveTemplateUseCase removeTemplateUseCase =
      MockRemoveTemplateUseCase();
  final MockUpdateTemplateUseCase updateTemplateUseCase =
      MockUpdateTemplateUseCase();

  TemplatesBloc bloc;

  setUp(() {
    bloc = TemplatesBloc(
        addTemplateUseCase: addTemplateUseCase,
        getTemplateUseCase: getTemplateUseCase,
        getTemplatesUseCase: getTemplatesUseCase,
        removeTemplateUseCase: removeTemplateUseCase,
        updateTemplateUseCase: updateTemplateUseCase);
  });

  test("AddTemplateEvent", () async {
    final template = templateFixtures.first;
    final params = AddTemplateUseCaseParams(template);

    when(getTemplatesUseCase.call(any)).thenAnswer((_) async => Right(templateFixtures));
    when(addTemplateUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialTemplatesState(), TemplatesAvailableState(templateFixtures)];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = AddTemplateEvent(template);
    bloc.dispatch(event);
  });

  test("GetTemplateEvent", () async {
    final template = templateFixtures.first;
    final params = GetTemplateUseCaseParams(template.id);

    when(getTemplateUseCase.call(params))
        .thenAnswer((_) async => Right(template));

    final expected = [
      InitialTemplatesState(),
      TemplateAvailableState(template)
    ];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = GetTemplateEvent(template.id);
    bloc.dispatch(event);
  });

  test("GetTemplatesEvent", () async {
    when(getTemplatesUseCase.call(any))
        .thenAnswer((_) async => Right(templateFixtures));

    final expected = [
      InitialTemplatesState(),
      TemplatesAvailableState(templateFixtures)
    ];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = GetTemplatesEvent();
    bloc.dispatch(event);
  });

  test("RemoveTemplateEvent", () async {
    final template = templateFixtures.first;
    final params = RemoveTemplateUseCaseParams(template.id);

    when(getTemplatesUseCase.call(any)).thenAnswer((_) async => Right(templateFixtures));

    when(removeTemplateUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialTemplatesState(), TemplatesAvailableState(templateFixtures)];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = RemoveTemplateEvent(template.id);
    bloc.dispatch(event);
  });

  test("UpdateTemplateEvent", () async {
    final template = templateFixtures.first;
    final update = Template(template.id, name: "update", fields: []);
    final params = UpdateTemplateUseCaseParams(update.id,
        fields: update.fields, name: update.name);

    when(getTemplatesUseCase.call(any)).thenAnswer((_) async => Right(templateFixtures));

    when(updateTemplateUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialTemplatesState(), TemplatesAvailableState(templateFixtures)];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = UpdateTemplateEvent(update.id,
        name: update.name, fields: update.fields);
    bloc.dispatch(event);
  });
}
