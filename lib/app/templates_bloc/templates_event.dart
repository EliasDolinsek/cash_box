import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:equatable/equatable.dart';

abstract class TemplatesEvent extends Equatable {}

class AddTemplateEvent extends TemplatesEvent {
  final Template template;

  AddTemplateEvent(this.template);

  @override
  List get props => [template];
}

class GetTemplateEvent extends TemplatesEvent {
  final String templateID;

  GetTemplateEvent(this.templateID);

  @override
  List get props => [templateID];
}

class GetTemplatesEvent extends TemplatesEvent {}

class RemoveTemplateEvent extends TemplatesEvent {
  final String templateID;

  RemoveTemplateEvent(this.templateID);

  @override
  List get props => [templateID];
}

class UpdateTemplateEvent extends TemplatesEvent {

  final String id, name;
  final List<Field> fields;

  UpdateTemplateEvent(this.id, {this.name, this.fields});

  @override
  List get props => [id, name, fields];
}
