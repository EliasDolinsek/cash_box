import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

import 'field.dart';

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

enum ReceiptType { income, outcome, investment, bank_statement }

class ReceiptTypeConverter {

  static String asString(ReceiptType type) {
    switch(type){
      case ReceiptType.income: return "income";
      case ReceiptType.outcome: return "outcome";
      case ReceiptType.investment: return "investment";
      case ReceiptType.bank_statement: return "bank_statement";
      default: throw new Exception("Couldn't convert ReceiptType: $type to string");
    }
  }

  static ReceiptType fromString(String type){
    switch(type){
      case "income": return ReceiptType.income;
      case "outcome": return ReceiptType.outcome;
      case "investment": return ReceiptType.investment;
      case "bank_statement": return ReceiptType.bank_statement;
      default: throw new Exception("Couldn't resolve ReceiptType from String $type");
    }
  }
}

