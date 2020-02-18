import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:meta/meta.dart';

class TemplateModel extends Template {

  TemplateModel(String id, {@required String name, @required List<Field> fields})
      : super(id, name: name, fields: fields);

}
