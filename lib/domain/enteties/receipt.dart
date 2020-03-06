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
      : super(id, params: [
          type,
          creationDate.year,
          creationDate.month,
          creationDate.day,
          creationDate.hour,
          creationDate.minute,
          creationDate.second,
          fields,
          tagIDs
        ]);

  @override
  String toString() {
    return 'Receipt{type: $type, creationDate: $creationDate, fields: $fields, tagIDs: $tagIDs}';
  }
}

enum ReceiptType { INCOME, OUTCOME, INVESTMENT, BANK_STATEMENT }

class ReceiptTypeConverter {

  static String asString(ReceiptType type) {
    switch(type){
      case ReceiptType.INCOME: return "income";
      case ReceiptType.OUTCOME: return "outcome";
      case ReceiptType.INVESTMENT: return "investment";
      case ReceiptType.BANK_STATEMENT: return "bank_statement";
      default: throw new Exception("Couldn't convert ReceiptType: $type to string");
    }
  }

  static ReceiptType fromString(String type){
    switch(type){
      case "income": return ReceiptType.INCOME;
      case "outcome": return ReceiptType.OUTCOME;
      case "investment": return ReceiptType.INVESTMENT;
      case "bank_statement": return ReceiptType.BANK_STATEMENT;
      default: throw new Exception("Couldn't resolve ReceiptType from String $type");
    }
  }
}

