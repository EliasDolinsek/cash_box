import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddTemplateUseCase extends AsyncUseCase<EmptyData, AddTemplateUseCaseParams> {

  final TemplatesRepository repository;

  AddTemplateUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddTemplateUseCaseParams params) async {
    return await repository.addTemplate(params.template);
  }

}

class AddTemplateUseCaseParams extends Equatable {

  final Template template;

  AddTemplateUseCaseParams(this.template) : super([template]);

}