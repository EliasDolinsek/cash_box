import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/add_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/get_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/get_templates_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/remove_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/update_template_use_case.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class TemplatesBloc extends Bloc<TemplatesEvent, TemplatesState> {
  final AddTemplateUseCase addTemplateUseCase;
  final GetTemplateUseCase getTemplateUseCase;
  final GetTemplatesUseCase getTemplatesUseCase;
  final RemoveTemplateUseCase removeTemplateUseCase;
  final UpdateTemplateUseCase updateTemplateUseCase;

  TemplatesBloc(
      {@required this.addTemplateUseCase,
      @required this.getTemplateUseCase,
      @required this.getTemplatesUseCase,
      @required this.removeTemplateUseCase,
      @required this.updateTemplateUseCase});

  @override
  TemplatesState get initialState => InitialTemplatesState();

  @override
  Stream<TemplatesState> mapEventToState(
    TemplatesEvent event,
  ) async* {
    if (event is AddTemplateEvent) {
      final params = AddTemplateUseCaseParams(event.template);
      await addTemplateUseCase(params);
    } else if (event is GetTemplateEvent) {
      yield await _getTemplate(event);
    } else if (event is GetTemplatesEvent) {
      yield await _getTemplates();
    } else if (event is RemoveTemplateEvent) {
      final params = RemoveTemplateUseCaseParams(event.templateID);
      await removeTemplateUseCase(params);
    } else if (event is UpdateTemplateEvent) {
      final params = UpdateTemplateUseCaseParams(event.id,
          name: event.name, fields: event.fields);
      await updateTemplateUseCase(params);
    }
  }

  Future<TemplatesState> _getTemplate(GetTemplateEvent event) async {
    final params = GetTemplateUseCaseParams(event.templateID);
    final templatesEither = await getTemplateUseCase(params);
    return templatesEither.fold((l) => TemplatesErrorState(l.toString()),
        (template) {
      return TemplateAvailableState(template);
    });
  }

  Future<TemplatesState> _getTemplates() async {
    final templatesEither = await getTemplatesUseCase(NoParams());
    return templatesEither.fold((l) => TemplatesErrorState(l.toString()),
        (templates) {
      return TemplatesAvailableState(templates);
    });
  }
}
