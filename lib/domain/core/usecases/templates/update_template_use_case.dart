import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/domain/core/usecases/templates/get_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateTemplateUseCase
    extends UseCase<EmptyData, UpdateTemplateUseCaseParams> {

  final TemplatesRepository repository;

  UpdateTemplateUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(
      UpdateTemplateUseCaseParams params) async {
    final templateEither = await _getTemplate(params.id);
    return templateEither.fold((failure) => Left(failure), (template) {
      final updatedTemplate = _getUpdateTemplate(template, params);
      return repository.updateTemplate(template.id, updatedTemplate);
    });
  }

  Template _getUpdateTemplate(Template template,
      UpdateTemplateUseCaseParams params) {
    return Template(template.id, name: params.name ?? template.name,
        fields: params.fields ?? template.fields);
  }

  Future<Either<Failure, Template>> _getTemplate(String id) async {
    final params = GetTemplateUseCaseParams(id);
    final getTemplateUseCase = GetTemplateUseCase(repository);
    return await getTemplateUseCase(params);
  }

}

class UpdateTemplateUseCaseParams extends Equatable {

  final String id, name;
  final List<Field> fields;

  UpdateTemplateUseCaseParams(this.id, {this.name, this.fields})
      : super([name, fields]);
}