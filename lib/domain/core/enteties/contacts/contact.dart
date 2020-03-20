import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../fields/field.dart';

part 'contact.g.dart';

@JsonSerializable(nullable: false)
class Contact extends UniqueComponent {

  final String name;
  final List<Field> fields;

  Contact(String id, {@required this.name, @required this.fields}) : super(id, params: [name, fields]);

  factory Contact.newContact({@required String name, @required List<Field> fields}){
    final id = Uuid().v4();
    return Contact(id, name: name, fields: fields);
  }

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
