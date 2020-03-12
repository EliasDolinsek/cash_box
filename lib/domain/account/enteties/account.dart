import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:meta/meta.dart';

part 'account.g.dart';

@JsonSerializable(nullable: false)
class Account extends Equatable {
  final SignInSource signInSource;
  final AccountType accountType;
  final String email, password;
  final String name;
  final String userID;

  Account(
      {@required this.userID,
      @required this.signInSource,
      @required this.accountType,
      @required this.email,
      @required this.password,
      @required this.name});

  factory Account.fromJSON(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJSON() => _$AccountToJson(this);

  @override
  List get props => [accountType, email, password, name, userID, signInSource];
}

enum AccountType { private, business }

enum SignInSource { firebase }
