import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:equatable/equatable.dart';

abstract class TemplatesState extends Equatable {}

class TemplatesLoadingState extends TemplatesState {
  @override
  List<Object> get props => [];
}

class TemplatesAvailableState extends TemplatesState {
  final List<Template> templates;

  TemplatesAvailableState(this.templates);

  @override
  List get props => [templates];
}
