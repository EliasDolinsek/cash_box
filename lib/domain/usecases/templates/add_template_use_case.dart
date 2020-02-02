import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/templates_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddTemplateUseCase extends UseCase<EmptyData, AddTemplateUseCaseParams> {

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