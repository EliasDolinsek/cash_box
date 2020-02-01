import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/unique_component.dart';
import 'package:meta/meta.dart';

class Contact extends UniqueComponent {
  final List<Field> fields;

  Contact(String id, {@required this.fields}) : super(id, params: [fields]);
}
