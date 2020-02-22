import 'package:cash_box/data/models/model.dart';
import 'package:cash_box/domain/enteties/field.dart';
import 'package:meta/meta.dart';

class FieldModel extends Field implements Model{

  FieldModel(String id, {@required FieldType type, @required String description, @required dynamic value})
      : super(id, type: type, description: description, value: value);

  factory FieldModel.fromField(Field field){
    return FieldModel(field.id, type: field.type, description: field.description, value: field.value);
  }

  factory FieldModel.fromMap(Map<String, dynamic> map){
    final type = map["type"];
    final id = map["id"];
    final description = map["description"];
    final value = map["value"];

    return _fromData(type, id, description, value);
  }

  dynamic get writableValue {
    if(type == FieldType.DATE){
      return value.millisecondsSinceEpoch;
    } else {
      return value;
    }
  }

  String get typeAsString {
    if(type == FieldType.DATE){
      return "date";
    } else if(type == FieldType.IMAGE){
      return "image";
    } else if(type == FieldType.TEXT){
      return "text";
    } else if(type == FieldType.AMOUNT){
      return "amount";
    } else if(type == FieldType.FILE) {
      return "file";
    } else{
      throw new Exception("Couldn't resolve string for FieldType $type");
    }
  }

  static FieldModel _fromData(String type, String id, String description, dynamic data){
    if(type == "amount" && data is double){
      return _amountModelFromData(id, description, data);
    } else if(type == "date"){
      return _dateModelFromData(id, description, data);
    } else if(type == "image"){
      return _imageModelFromData(id, description, data);
    } else if(type == "text"){
      return _textModelFromData(id, description, data);
    } else if(type == "file") {
      return _fileModelFromData(id, description, data);
    } else {
      throw new Exception("Invalid field-type: type=$type value=$data");
    }
  }

  static FieldModel _fileModelFromData(String id, String description, String data){
    return FieldModel(id, type: FieldType.FILE, description: description, value: data);
  }

  static FieldModel _textModelFromData(String id, String description, String text){
    return FieldModel(id, type: FieldType.TEXT, description: description, value: text);
  }

  static FieldModel _imageModelFromData(String id, String description, String src){
    return FieldModel(id, type: FieldType.IMAGE, description: description, value: src);
  }

  static FieldModel _amountModelFromData(String id, String description, double amount){
    return FieldModel(id, type: FieldType.AMOUNT, description: description, value: amount);
  }

  static FieldModel _dateModelFromData(String id, String description, int millisecondsSinceEpoch){
    final date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return FieldModel(id, type: FieldType.DATE, description: description, value: date);
  }

  Map<String, dynamic> toMap(){
    return {
      "id":id,
      "type":typeAsString,
      "description":description,
      "value":writableValue,
    };
  }

}
