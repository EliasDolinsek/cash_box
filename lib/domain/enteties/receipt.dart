import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/unique_component.dart';

class Receipt extends UniqueComponent{

  final ReceiptType type;
  final DateTime creationDate;
  final List<Field> fields;
  final List<String> tagIDs;

  Receipt(String id, this.type, this.creationDate, this.fields, this.tagIDs) : super(id);

}

enum ReceiptType {

  INCOME, OUTCOME, INVESTMENT
}