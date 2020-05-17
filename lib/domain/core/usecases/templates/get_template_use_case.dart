import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTemplateUseCase extends AsyncUseCase<Template, GetTemplateUseCaseParams> {
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
