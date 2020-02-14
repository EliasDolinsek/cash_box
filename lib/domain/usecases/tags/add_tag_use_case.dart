import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/tag.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/tags_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddTagUseCase extends UseCase<EmptyData, AddTagUseCaseParams> {

  final TagsRepository repository;

  AddTagUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddTagUseCaseParams params) {
    return repository.addTag(params.tag);
  }

}

class AddTagUseCaseParams extends Equatable {

  final Tag tag;

  AddTagUseCaseParams(this.tag) : super([tag]);
}