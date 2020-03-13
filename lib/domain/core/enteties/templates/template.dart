import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

import '../fields/field.dart';

part 'template.g.dart';

@JsonSerializable(nullable: false)
class Template extends UniqueComponent {
  final String name;
  final List<Field> fields;

  Template(String id, {@required this.name, @required this.fields})
      : super(id, params: [name, fields]);

  factory Template.fromJson(Map<String, dynamic> json) => _$TemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateToJson(this);

  @override
  String toString() {
    return 'Template{id: $id, name: $name, fields: $fields}';
  }

}
