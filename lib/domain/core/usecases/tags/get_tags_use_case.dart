import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/tag.dart';
import 'package:cash_box/domain/core/repositories/tags_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/use_case.dart';

class GetTagsUseCase extends UseCase<List<Tag>, NoParams> {

  final TagsRepository repository;

  GetTagsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Tag>>> call(NoParams params) {
    return repository.getTags();
  }

}