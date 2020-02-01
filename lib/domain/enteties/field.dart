import 'package:cash_box/domain/enteties/unique_component.dart';
import 'package:meta/meta.dart';

class Field<Value> extends UniqueComponent {

  final String key, description;
  final Value value;

  Field(String id, {@required this.key, @required this.description, @required this.value})
      : super(id, params: [key, description, value]);
}
