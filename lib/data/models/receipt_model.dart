import 'package:cash_box/data/models/field_model.dart';
import 'package:cash_box/data/models/model.dart';
import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:meta/meta.dart';

class ReceiptModel extends Receipt implements Model {

  ReceiptModel(String id,
      {@required ReceiptType type,
      @required DateTime creationDate,
      @required List<Field> fields,
      @required List<String> tagIDs})
      : super(
          id,
          type: type,
          creationDate: creationDate,
          fields: fields,
          tagIDs: tagIDs,
        );

  factory ReceiptModel.fromMap(Map<String, dynamic> map){
    final type = ReceiptTypeConverter.fromString(map["type"]);
    final creationDate = DateTime.fromMillisecondsSinceEpoch(map["creationDate"]);

    final List fieldsAsMapList = map["fields"];
    final fieldsList = fieldsAsMapList.map((fieldMap) => FieldModel.fromMap(fieldMap)).toList();
    return ReceiptModel(map["id"], type: type, creationDate: creationDate, fields: fieldsList, tagIDs: map["tagIDs"]);
  }

  @override
  Map<String, dynamic> toMap() {
    final fieldsAsMap = fields.map((field) => FieldModel.fromField(field).toMap()).toList();
    return {
      "id":id,
      "type":ReceiptTypeConverter.asString(type),
      "creationDate":creationDate.millisecondsSinceEpoch,
      "fields":fieldsAsMap,
      "tagIDs":tagIDs
    };
  }
}
