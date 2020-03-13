import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

import '../fields/field.dart';

part 'contact.g.dart';

@JsonSerializable(nullable: false)
class Contact extends UniqueComponent {
  final List<Field> fields;

  Contact(String id, {@required this.fields}) : super(id, params: [fields]);

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
