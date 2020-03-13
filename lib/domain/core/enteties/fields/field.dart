import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

part 'field.g.dart';

@JsonSerializable(nullable: false)
class Field extends UniqueComponent {

  final FieldType type;
  final String description;
  final dynamic value;

  Field(String id, {@required this.type, @required this.description, @required this.value})
      : super(id, params: [type, description, value]);

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

enum FieldType { AMOUNT, DATE, IMAGE, TEXT, FILE }