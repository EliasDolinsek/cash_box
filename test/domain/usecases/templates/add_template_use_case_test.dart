import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/templates_repository.dart';
import 'package:cash_box/domain/usecases/templates/add_template_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/field_fixtures.dart';

class MockTemplatesRepository extends Mock implements TemplatesRepository {}

void main(){

  MockTemplatesRepository repository;
  AddTemplateUseCase useCase;

  setUp((){
    repository = MockTemplatesRepository();
    useCase = AddTemplateUseCase(repository);
  });

  final testTemplate = Template("jkl-101112", name: "Test4", fields: fieldFixtures);
  test("should call the repository to add a template", () async {
    when(repository.addTemplate(any)).thenAnswer((_) async => Right(EmptyData()));


    final params = AddTemplateUseCaseParams(testTemplate);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.addTemplate(testTemplate));
  });
}