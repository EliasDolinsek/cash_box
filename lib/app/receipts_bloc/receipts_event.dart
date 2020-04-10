import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:equatable/equatable.dart';

abstract class ReceiptsEvent extends Equatable {}

class AddReceiptEvent extends ReceiptsEvent {
  final Receipt receipt;

  AddReceiptEvent(this.receipt);

  @override
  List get props => [receipt];
}

class GetReceiptsInReceiptMonthEvent extends ReceiptsEvent {
  final ReceiptMonth receiptMonth;

  GetReceiptsInReceiptMonthEvent(this.receiptMonth);

  @override
  List get props => [receiptMonth];
}

class GetReceiptsEvent extends ReceiptsEvent {}

class UpdateReceiptEvent extends ReceiptsEvent {

  final String id;
  final ReceiptType type;
  final List<Field> fields;
  final List<String> tagIDs;
  final DateTime creationDate;

  UpdateReceiptEvent(this.id, {this.type, this.fields, this.tagIDs, this.creationDate});

  @override
  List get props => [id, type, fields, tagIDs];
}

class RemoveReceiptEvent extends ReceiptsEvent {

  final String receiptID;

  RemoveReceiptEvent(this.receiptID);

  @override
  List get props => [receiptID];
}
