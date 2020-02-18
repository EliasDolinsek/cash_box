import 'package:cash_box/domain/enteties/contact.dart';
import 'package:cash_box/domain/enteties/field.dart';
import 'package:meta/meta.dart';

class ContactModel extends Contact {

  ContactModel(String id, {@required List<Field> fields}) : super(id, fields: fields);

}