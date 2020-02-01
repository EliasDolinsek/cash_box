import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/unique_component.dart';

class Template extends UniqueComponent{

  final String name;
  final List<Field> fields;

  Template(String id, this.name, this.fields) : super(id);
}