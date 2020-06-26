import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class ReceiptsSearchEvent extends SearchEvent {

  final String text;
  final List<String> tagIds;
  final DateTime month;
  final ReceiptType receiptType;

  ReceiptsSearchEvent(this.month, {this.text, this.tagIds, this.receiptType});

  @override
  List get props => [text, tagIds, receiptType];
}

class ReloadSearchEvent extends SearchEvent {

  final DateTime newMonth;

  ReloadSearchEvent({this.newMonth});

  @override
  List get props => [newMonth];
}