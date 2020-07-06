import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/repositories/repository.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:dartz/dartz.dart';

import 'empty_data.dart';

abstract class TemplatesRepository implements Repository{

  Future<Either<Failure, List<Template>>> getTemplates();
  Future<Either<Failure, EmptyData>> updateTemplate(String id, Template template);
  Future<Either<Failure, EmptyData>> removeTemplate(String id);
  Future<Either<Failure, EmptyData>> addTemplate(Template template);

}