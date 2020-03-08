import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/tag.dart';
import 'package:cash_box/domain/core/repositories/tags_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

class GetTagUseCase extends UseCase<Tag, GetTagUseCaseParams> {

  final TagsRepository repository;

  GetTagUseCase(this.repository);

  @override
  Future<Either<Failure, Tag>> call(GetTagUseCaseParams params) async {
    final tagsEither = await repository.getTags();
    return tagsEither.fold((failure) => Left(failure), (tagsList){
      final tag = _getTagFromID(params.id, tagsList);
      if(tag == null){
        return Left(TagNotFoundFailure());
      } else {
        return Right(tag);
      }
    });
  }

  Tag _getTagFromID(String id, List<Tag> tags){
    return tags.firstWhere((tag) => tag.id == id, orElse: () => null);
  }

}

class GetTagUseCaseParams extends Equatable {

  final String id;

  GetTagUseCaseParams(this.id) : super([id]);

}