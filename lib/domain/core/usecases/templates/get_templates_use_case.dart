import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

class GetTemplatesUseCase extends UseCase<List<Template>, NoParams> {
  final TemplatesRepository templatesRepository;

  GetTemplatesUseCase(this.templatesRepository);

  @override
  Future<Either<Failure, List<Template>>> call(NoParams params) async {
    return templatesRepository.getTemplates();
  }
}
