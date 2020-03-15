import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:equatable/equatable.dart';

abstract class TemplatesState extends Equatable {}

class InitialTemplatesState extends TemplatesState {
  @override
  List<Object> get props => [];
}

class TemplatesAvailableState extends TemplatesState {
  final List<Template> templates;

  TemplatesAvailableState(this.templates);

  @override
  List get props => [templates];
}

class TemplatesUnavailableState extends TemplatesState {}

class TemplatesErrorState extends TemplatesState {
  final String errorMessage;

  TemplatesErrorState(this.errorMessage);

  @override
  List get props => [errorMessage];
}

class TemplateAvailableState extends TemplatesState {
  final Template template;

  TemplateAvailableState(this.template);

  @override
  List get props => [template];
}
