import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

import 'field.dart';

class Contact extends UniqueComponent {
  final List<Field> fields;

  Contact(String id, {@required this.fields}) : super(id, params: [fields]);
}
