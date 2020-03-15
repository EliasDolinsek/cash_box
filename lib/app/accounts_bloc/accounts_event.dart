import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:equatable/equatable.dart';

abstract class AccountsEvent extends Equatable {}

class CreateAccountEvent extends AccountsEvent {
  final Account account;

  CreateAccountEvent(this.account);

  @override
  List get props => [account];
}

class DeleteAccountEvent extends AccountsEvent {
  final String userID;

  DeleteAccountEvent(this.userID);

  @override
  List get props => [userID];
}

class GetAccountEvent extends AccountsEvent {
  final String userID;

  GetAccountEvent(this.userID);

  @override
  List get props => [userID];
}

class UpdateAccountEvent extends AccountsEvent {
  final String userID;
  final String email, appPassword, name;
  final SubscriptionInfo subscriptionInfo;

  UpdateAccountEvent(
      {this.userID,
      this.email,
      this.appPassword,
      this.name,
      this.subscriptionInfo});

  @override
  List get props => [userID, email, appPassword, name, subscriptionInfo];
}
