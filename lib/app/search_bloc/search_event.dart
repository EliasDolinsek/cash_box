import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class ReceiptsSearchEvent extends SearchEvent {

  final String text;
  final List<String> tagIds;
  final ReceiptMonth receiptMonth;

  ReceiptsSearchEvent({this.text, this.tagIds, this.receiptMonth});

  @override
  List get props => [text, tagIds];
}