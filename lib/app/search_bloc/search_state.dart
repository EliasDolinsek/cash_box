import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

class LoadingSearchState extends SearchState {}

class ReceiptsSearchAvailableState extends SearchState {

  final List<Receipt> receipts;

  ReceiptsSearchAvailableState(this.receipts);

  @override
  List get props => [receipts];
}

class ErrorSearchState extends SearchState {

  final String errorMessage;

  ErrorSearchState(this.errorMessage);

  @override
  List get props => [errorMessage];
}