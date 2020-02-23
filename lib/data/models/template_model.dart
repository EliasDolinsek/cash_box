import 'package:cash_box/data/models/field_model.dart';
import 'package:cash_box/data/models/model.dart';
import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:meta/meta.dart';

class TemplateModel extends Template implements Model {

  TemplateModel(String id, {@required String name, @required List<Field> fields})
      : super(id, name: name, fields: fields);

  factory TemplateModel.fromMap(Map<String, dynamic> map){
    final List fieldsAsMapList = map["fields"];
    final fieldsAsList = fieldsAsMapList.map((fieldMap) => FieldModel.fromMap(fieldMap)).toList();
    return TemplateModel(map["id"], name: map["name"], fields: fieldsAsList);
  }

  @override
  Map<String, dynamic> toMap() {
    final fieldsAsMap = fields.map((field) => FieldModel.fromField(field).toMap()).toList();
    return {
      "id":id,
      "name":name,
      "fields": fieldsAsMap
    };
  }

}
