import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
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
  TemplatesState get initialState => TemplatesLoadingState();

  @override
  Stream<TemplatesState> mapEventToState(
    TemplatesEvent event,
  ) async* {
    if (event is AddTemplateEvent) {
      yield TemplatesLoadingState();

      final params = AddTemplateUseCaseParams(event.template);
      await addTemplateUseCase(params);

      dispatch(GetTemplatesEvent());
    } else if (event is GetTemplatesEvent) {
      yield TemplatesLoadingState();

      yield await _getTemplates();
    } else if (event is RemoveTemplateEvent) {
      yield TemplatesLoadingState();

      final params = RemoveTemplateUseCaseParams(event.templateID);
      await removeTemplateUseCase(params);

      dispatch(GetTemplatesEvent());
    } else if (event is UpdateTemplateEvent) {
      yield TemplatesLoadingState();

      final params = UpdateTemplateUseCaseParams(event.id,
          name: event.name, fields: event.fields);
      await updateTemplateUseCase(params);

      dispatch(GetTemplatesEvent());
    }
  }

  Future<TemplatesState> _getTemplates() async {
    final templatesEither = await getTemplatesUseCase(NoParams());
    return templatesEither.fold((l) => TemplatesAvailableState(null),
        (templates) {
      return TemplatesAvailableState(templates);
    });
  }
}
