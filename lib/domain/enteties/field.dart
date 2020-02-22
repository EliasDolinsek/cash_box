import 'package:cash_box/domain/enteties/unique_component.dart';
import 'package:meta/meta.dart';

class Field extends UniqueComponent {

  final FieldType type;
  final String description;
  final dynamic value;

  Field(String id, {@required this.type, @required this.description, @required this.value})
      : super(id, params: [type, description, value]);

}

enum FieldType { AMOUNT, DATE, IMAGE, TEXT, FILE }