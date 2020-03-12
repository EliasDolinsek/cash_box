import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/tag.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/tags_repository.dart';
import 'package:cash_box/domain/core/usecases/tags/get_tag_use_case.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateTagUseCase extends UseCase<EmptyData, UpdateTagUseCaseParams> {

  final TagsRepository repository;

  UpdateTagUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(UpdateTagUseCaseParams params) async {
    final tagEither = await _getTagById(params.id);
    return tagEither.fold((failure) => Left(failure), (tag){
      return repository.updateTag(params.id, _getUpdatedTag(tag, params));
    });
  }

  Tag _getUpdatedTag(Tag tag, UpdateTagUseCaseParams params) {
    return Tag(tag.id, name: params.name ?? tag.name,
        color: params.color ?? tag.color);
  }

  Future<Either<Failure, Tag>> _getTagById(String id){
    final params = GetTagUseCaseParams(id);
    final getTagUseCase = GetTagUseCase(repository);
    return getTagUseCase(params);
  }
}

class UpdateTagUseCaseParams extends Equatable {

  final String id, name, color;

  UpdateTagUseCaseParams(this.id, {this.name, this.color})
      : super([id, name, color]);

}