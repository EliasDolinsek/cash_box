import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveTemplateUseCase extends UseCase<EmptyData, RemoveTemplateUseCaseParams> {

  final TemplatesRepository repository;

  RemoveTemplateUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(RemoveTemplateUseCaseParams params) async {
    return await repository.removeTemplate(params.id);
  }

}

class RemoveTemplateUseCaseParams extends Equatable {

  final String id;

  RemoveTemplateUseCaseParams(this.id) : super([id]);

}