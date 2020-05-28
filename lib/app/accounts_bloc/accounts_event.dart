import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
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

class GetAccountEvent extends AccountsEvent {}

class UpdateAccountEvent extends AccountsEvent {

  final String name;
  final String appPassword;
  final String email;
  final String currencyCode;
  final SubscriptionInfo subscriptionInfo;

  UpdateAccountEvent({this.name, this.appPassword, this.email, this.currencyCode, this.subscriptionInfo});

  UpdateAccountUseCaseParams asParams(String userId) =>
      UpdateAccountUseCaseParams(
        userId,
        name: name,
        appPassword: appPassword,
        email: email,
        subscriptionInfo: subscriptionInfo,
        currencyCode: currencyCode
      );
}
