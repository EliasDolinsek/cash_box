import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/tag.dart';
import 'package:cash_box/domain/repositories/tags_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

class GetTagsUseCase extends UseCase<List<Tag>, NoParams> {

  final TagsRepository repository;

  GetTagsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Tag>>> call(NoParams params) {
    return repository.getTags();
  }

}