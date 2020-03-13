import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/domain/core/usecases/templates/update_template_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/field_fixtures.dart';
import '../../../../fixtures/templates_fixtures.dart';

class MockTemplatesRepository extends Mock implements TemplatesRepository {}

void main() {
  MockTemplatesRepository repository;
  UpdateTemplateUseCase useCase;

  setUp(() {
    repository = MockTemplatesRepository();
    useCase = UpdateTemplateUseCase(repository);
  });

  final testID = "abc-123";
  test("should update the name of the template", () async {
    final testName = "UPDATE";
    when(repository.getTemplates())
        .thenAnswer((_) async => Right(templateFixtures));
    when(repository.updateTemplate(testID, any)).thenAnswer((_) async => Right(EmptyData()));

    final params = UpdateTemplateUseCaseParams(testID, name: testName);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    final expectedTemplate =
    Template(testID, name: testName, fields: templateFixtures.first.fields);
    verify(repository.updateTemplate(testID, expectedTemplate));
  });

  test("should update the fields of the template", () async {
    final testFields = fieldFixtures..removeLast();
    when(repository.getTemplates())
        .thenAnswer((_) async => Right(templateFixtures));
    when(repository.updateTemplate(testID, any)).thenAnswer((_) async => Right(EmptyData()));

    final params = UpdateTemplateUseCaseParams(testID, fields: testFields);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    final expectedTemplate =
    Template(testID, name: templateFixtures.first.name, fields: testFields);
    verify(repository.updateTemplate(testID, expectedTemplate));
  });
}
