import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

import 'field.dart';

class Template extends UniqueComponent {
  final String name;
  final List<Field> fields;

  Template(String id, {@required this.name, @required this.fields})
      : super(id, params: [name, fields]);

  @override
  String toString() {
    return 'Template{id: $id, name: $name, fields: $fields}';
  }


}
