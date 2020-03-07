import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/data/repositories/repository.dart';
import 'package:cash_box/domain/enteties/tag.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class TagsRepository implements Repository{

  Future<Either<Failure, EmptyData>> addTag(Tag tag);
  Future<Either<Failure, EmptyData>> removeTag(String id);
  Future<Either<Failure, EmptyData>> updateTag(String id, Tag update);

  Future<Either<Failure, List<Tag>>> getTags();
}