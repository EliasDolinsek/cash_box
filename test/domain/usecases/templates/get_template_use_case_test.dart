import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/templates_repository.dart';
import 'package:cash_box/domain/usecases/templates/get_template_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/templates_fixtures.dart';

class MockTemplatesRepository extends Mock implements TemplatesRepository {}

void main(){

  MockTemplatesRepository repository;
  GetTemplateUseCase useCase;

  setUp((){
    repository = MockTemplatesRepository();
    useCase = GetTemplateUseCase(repository);
  });

  final testID = "abc-123";
  final testFailureID = "not_found";

  test("should get a template by id", () async {
    when(repository.getTemplates()).thenAnswer((_) async => Right(templateFixtures));

    final params = GetTemplateUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(templateFixtures.first));
    verify(repository.getTemplates());
  });

  test("should return a TemplateNotFoundFailure if the template-id doesn't exist", () async {
    when(repository.getTemplates()).thenAnswer((_) async => Right(templateFixtures));

    final params = GetTemplateUseCaseParams(testFailureID);
    final result = await useCase(params);

    expect(result, Left(TemplateNotFoundFailure()));
    verify(repository.getTemplates());
  });
}