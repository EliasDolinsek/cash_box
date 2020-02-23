import 'package:cash_box/data/models/model.dart';
import 'package:cash_box/domain/enteties/tag.dart';

import 'package:meta/meta.dart';

class TagModel extends Tag implements Model {

  TagModel(String id, {@required String name, @required String color})
      : super(id, name: name, color: color);

  factory TagModel.fromMap(Map<String, dynamic> map){
    return TagModel(map["id"], name: map["name"], color: map["color"]);
  }
  
  @override
  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "name":name,
      "color":color,
    };
  }

}
