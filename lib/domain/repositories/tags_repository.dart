import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/tag.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class TagsRepository {

  Future<Either<Failure, EmptyData>> addTag(Tag tag);
  Future<Either<Failure, EmptyData>> removeTag(String id);
  Future<Either<Failure, EmptyData>> updateTag(String id, Tag update);

  Future<Either<Failure, List<Tag>>> getTags();
  Future<Either<Failure, Tag>> getTag(String id);
}