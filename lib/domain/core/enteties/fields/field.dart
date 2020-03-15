import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'field.g.dart';

@JsonSerializable(nullable: false)
class Field extends UniqueComponent {

  final FieldType type;
  final String description;
  final dynamic value;

  Field(String id, {@required this.type, @required this.description, @required this.value})
      : super(id, params: [type, description, value]);

  factory Field.newField({@required FieldType type, @required String description, @required dynamic value}){
    final id = Uuid().v4();
    return Field(id, type: type, description: description, value: value);
  }
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

enum FieldType { amount, date, image, text, file }