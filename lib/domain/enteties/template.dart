import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/unique_component.dart';
import 'package:meta/meta.dart';

class Template extends UniqueComponent {
  final String name;
  final List<Field> fields;

  Template(String id, {@required this.name, @required this.fields})
      : super(id, params: [name, fields]);
}
