import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/unique_component.dart';

class Contact extends UniqueComponent{

  final List<Field> fields;

  Contact(String id, this.fields) : super(id);
}