import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:equatable/equatable.dart';

abstract class AccountsState extends Equatable {}

class InitialAccountsState extends AccountsState {
  @override
  List<Object> get props => [];
}

class AccountAvailableState extends AccountsState {
  final Account account;

  AccountAvailableState(this.account);

  @override
  List get props => [account];
}

class AccountUnavailableState extends AccountsState {}

class AccountErrorState extends AccountsState {

  final String errorMessage;

  AccountErrorState(this.errorMessage);
}
