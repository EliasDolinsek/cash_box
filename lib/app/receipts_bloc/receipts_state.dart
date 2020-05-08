import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:equatable/equatable.dart';

abstract class ReceiptsState extends Equatable {}

class InitialReceiptsState extends ReceiptsState {
  @override
  List<Object> get props => [];
}

class ReceiptsInReceiptMonthAvailableState extends ReceiptsState {

  final ReceiptMonth month;
  final List<Receipt> receipts;

  ReceiptsInReceiptMonthAvailableState(this.month, this.receipts);

  @override
  List get props => [month, receipts];
}

class ReceiptsAvailableState extends ReceiptsState {

  final List<Receipt> receipts;

  ReceiptsAvailableState(this.receipts);

  @override
  List get props => [receipts];
}

class ReceiptsErrorState extends ReceiptsState {

  final String errorMessage;

  ReceiptsErrorState(this.errorMessage);

}