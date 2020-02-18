import 'package:cash_box/domain/enteties/tag.dart';

import 'package:meta/meta.dart';

class TagModel extends Tag {

  TagModel(String id, {@required String name, @required String color})
      : super(id, name: name, color: color);

}
