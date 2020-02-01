import 'package:meta/meta.dart';

class Field<Value> {

  final String key, description;
  final Value value;

  Field(this.key, this.description, this.value);

}