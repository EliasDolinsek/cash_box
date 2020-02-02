import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/templates_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTemplateUseCase extends UseCase<Template, GetTemplateUseCaseParams> {
  final TemplatesRepository repository;

  GetTemplateUseCase(this.repository);

  @override
  Future<Either<Failure, Template>> call(
      GetTemplateUseCaseParams params) async {
    final templatesEither = await repository.getTemplates();
    return templatesEither.fold((failure) => Left(failure), (templatesList) {
      final template = _getTemplate(params.id, templatesList);
      if(template == null){
        return Left(TemplateNotFoundFailure());
      } else {
        return Right(template);
      }
    });
  }

  Template _getTemplate(String id, List<Template> templates){
    return templates.firstWhere((t) => t.id == id, orElse: () => null);
  }
}

class GetTemplateUseCaseParams extends Equatable {
  final String id;

  GetTemplateUseCaseParams(this.id) : super([id]);
}
