import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:equatable/equatable.dart';

abstract class ReceiptsState extends Equatable {}

class LoadingReceiptsState extends ReceiptsState {
  @override
  List<Object> get props => [];
}

class ReceiptsAvailableState extends ReceiptsState {

  final DateTime month;
  final List<Receipt> receipts;

  ReceiptsAvailableState(this.receipts, this.month);

  @override
  List get props => [receipts];
}