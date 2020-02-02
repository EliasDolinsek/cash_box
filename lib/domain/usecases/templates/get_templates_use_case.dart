import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/templates_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

class GetTemplatesUseCase extends UseCase<List<Template>, NoParams> {
  final TemplatesRepository templatesRepository;

  GetTemplatesUseCase(this.templatesRepository);

  @override
  Future<Either<Failure, List<Template>>> call(NoParams params) async {
    return templatesRepository.getTemplates();
  }
}
