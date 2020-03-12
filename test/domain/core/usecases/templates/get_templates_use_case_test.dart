import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/domain/core/usecases/templates/get_templates_use_case.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/templates_fixtures.dart';

class MockTemplatesRepository extends Mock implements TemplatesRepository {}

void main(){
  
  MockTemplatesRepository repository;
  GetTemplatesUseCase useCase;
  
  setUp((){
    repository = MockTemplatesRepository();
    useCase = GetTemplatesUseCase(repository);
  });

  test("should call teh repository to get all templates", () async {
    when(repository.getTemplates()).thenAnswer((_) async => Right(templateFixtures));

    final result = await useCase(NoParams());

    expect(result, Right(templateFixtures));
  });
}