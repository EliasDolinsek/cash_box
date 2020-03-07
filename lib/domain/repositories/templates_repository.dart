import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/data/repositories/repository.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class TemplatesRepository implements Repository{

  Future<Either<Failure, List<Template>>> getTemplates();
  Future<Either<Failure, EmptyData>> updateTemplate(String id, Template template);
  Future<Either<Failure, EmptyData>> removeTemplate(String id);
  Future<Either<Failure, EmptyData>> addTemplate(Template template);

}