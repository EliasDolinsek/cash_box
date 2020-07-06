import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/repositories/repository.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:dartz/dartz.dart';

import 'empty_data.dart';

abstract class TagsRepository implements Repository{

  Future<Either<Failure, EmptyData>> addTag(Tag tag);
  Future<Either<Failure, EmptyData>> removeTag(String id);
  Future<Either<Failure, EmptyData>> updateTag(String id, Tag update);

  Future<Either<Failure, List<Tag>>> getTags();
}