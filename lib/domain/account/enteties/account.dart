import 'package:cash_box/domain/account/enteties/subscription.dart';

import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:meta/meta.dart';

part 'account.g.dart';

@JsonSerializable(nullable: false)
class Account extends Equatable {

  final SignInSource signInSource;
  final AccountType accountType;
  final String email, appPassword;
  final String name;
  final String userID;
  final SubscriptionInfo subscriptionInfo;

  Account(
      {@required this.userID,
      @required this.signInSource,
      @required this.accountType,
      @required this.email,
      @required this.appPassword,
      @required this.name,
      @required this.subscriptionInfo});

  factory Account.fromJSON(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJSON() => _$AccountToJson(this);

  @override
  List get props => [accountType, email, appPassword, name, userID, signInSource, subscriptionInfo];
}

enum AccountType { private, business }

enum SignInSource { firebase }
