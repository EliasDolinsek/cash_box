import 'package:cash_box/data/core/models/field_model.dart';
import 'package:cash_box/data/core/models/model.dart';
import 'package:cash_box/domain/core/enteties/contact.dart';
import 'package:cash_box/domain/core/enteties/field.dart';
import 'package:meta/meta.dart';

class ContactModel extends Contact implements Model{

  ContactModel(String id, {@required List<Field> fields}) : super(id, fields: fields);

  factory ContactModel.fromContact(Contact contact){
    return ContactModel(contact.id, fields: contact.fields);
  }

  factory ContactModel.fromMap(Map<String, dynamic> map){
    final List fieldsAsMapList = map["fields"];
    final fieldsList = fieldsAsMapList.map((fieldMap) => FieldModel.fromMap(fieldMap)).toList();

    return ContactModel(map["id"], fields: fieldsList);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "fields":fields.map((field) => FieldModel.fromField(field).toMap()).toList()
    };
  }

}