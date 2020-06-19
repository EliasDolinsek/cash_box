import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'field.g.dart';

@JsonSerializable(nullable: false)
class Field extends UniqueComponent {
  final bool storageOnly;
  final FieldType type;
  final String description;
  final dynamic value;

  Field(String id,
      {@required this.type,
      @required this.description,
      @required this.value,
      @required this.storageOnly})
      : super(id, params: [type, description, value, storageOnly]);

  factory Field.newField(
      {@required FieldType type,
      @required String description,
      @required dynamic value,
      @required bool storageOnly}) {
    final id = Uuid().v4();
    return Field(id,
        type: type,
        description: description,
        value: value,
        storageOnly: storageOnly);
  }

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Field cloneWithNewId() => Field(
        Uuid().v4(),
        type: type,
        description: description,
        value: value,
        storageOnly: storageOnly,
      );

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

enum FieldType { amount, date, image, text, file }
