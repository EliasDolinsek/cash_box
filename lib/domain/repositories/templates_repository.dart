import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class TemplatesRepository {

  Future<Either<Failure, List<Template>>> getTemplates();
  Future<Either<Failure, Template>> getTemplate(String id);
  Future<Either<Failure, EmptyData>> updateTemplate(String id, Template template);
  Future<Either<Failure, EmptyData>> removeTemplate(String id);
  Future<Either<Failure, EmptyData>> addTemplate(Template template);

}