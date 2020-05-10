import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/tags_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

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