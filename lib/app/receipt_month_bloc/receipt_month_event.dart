import 'package:equatable/equatable.dart';

abstract class ReceiptMonthEvent extends Equatable {}

class SetReceiptMonthEvent extends ReceiptMonthEvent {

  final DateTime receiptMonth;

  SetReceiptMonthEvent(this.receiptMonth);

  @override
  List get props => [receiptMonth];
}
