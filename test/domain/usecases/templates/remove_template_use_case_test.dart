import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/templates_repository.dart';
import 'package:cash_box/domain/usecases/templates/remove_template_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTemplatesRepository extends Mock implements TemplatesRepository {}

void main() {
  MockTemplatesRepository repository;
  RemoveTemplateUseCase useCase;

  setUp(() {
    repository = MockTemplatesRepository();
    useCase = RemoveTemplateUseCase(repository);
  });

  final String testID = "abc-123";
  test("should call the repository to remove the template", () async {
    when(repository.removeTemplate(testID))
        .thenAnswer((_) async => Right(EmptyData()));
    
    final params = RemoveTemplateUseCaseParams(testID);
    final result = await useCase(params);
    
    expect(result, Right(EmptyData()));
    verify(repository.removeTemplate(testID));
  });
}
