import 'package:cash_box/domain/enteties/field.dart';
import 'package:meta/meta.dart';

class FieldModel<Value> extends Field {

  FieldModel(String id,
      {@required String key,
      @required String description,
      @required Value value})
      : super(id, key: key, description: description, value: value);
}
