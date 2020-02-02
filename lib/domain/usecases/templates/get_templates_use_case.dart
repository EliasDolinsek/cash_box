import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/templates_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTemplatesUseCase extends UseCase <EmptyData, GetTemplatesUseCaseParams> {

  final TemplatesRepository templatesRepository;

  GetTemplatesUseCase(this.templatesRepository);

  @override
  Future<Either<Failure, EmptyData>> call(GetTemplatesUseCaseParams params) async {
    return templatesRepository.addTemplate(params.template);
  }

}

class GetTemplatesUseCaseParams extends Equatable {

  final Template template;

  GetTemplatesUseCaseParams(this.template) : super([template]);

}