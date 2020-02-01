import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/unique_component.dart';
import 'package:meta/meta.dart';

class Receipt extends UniqueComponent {
  final ReceiptType type;
  final DateTime creationDate;
  final List<Field> fields;
  final List<String> tagIDs;

  Receipt(String id,
      {@required this.type,
      @required this.creationDate,
      @required this.fields,
      @required this.tagIDs})
      : super(id, params: [type, creationDate, fields, tagIDs]);
}

enum ReceiptType { INCOME, OUTCOME, INVESTMENT }
