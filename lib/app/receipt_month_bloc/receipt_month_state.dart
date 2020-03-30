import 'package:equatable/equatable.dart';

abstract class ReceiptMonthState extends Equatable {}

class ReceiptMonthAvailableState extends ReceiptMonthState {
  final DateTime month;

  ReceiptMonthAvailableState(this.month);

  @override
  List get props => [month];
}
