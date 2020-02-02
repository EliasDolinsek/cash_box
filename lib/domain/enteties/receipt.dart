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
      : super(id, params: [type, creationDate.year, creationDate.month, creationDate.day, creationDate.hour, creationDate.minute, creationDate.second, fields, tagIDs]);

  @override
  String toString() {
    return 'Receipt{type: $type, creationDate: $creationDate, fields: $fields, tagIDs: $tagIDs}';
  }
}

enum ReceiptType { INCOME, OUTCOME, INVESTMENT }
