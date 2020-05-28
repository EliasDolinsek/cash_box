import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:equatable/equatable.dart';

abstract class AccountsState extends Equatable {}

class AccountAvailableState extends AccountsState {
  final Account account;

  AccountAvailableState(this.account);

  @override
  List get props => [account];
}

class AccountsLoadingState extends AccountsState {}
