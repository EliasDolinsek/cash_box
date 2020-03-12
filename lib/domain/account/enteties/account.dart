import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(nullable: false)
class Account extends Equatable {

  final AccountType accountType;
  final String email, password;
  final String name;

  Account(this.accountType, this.email, this.password, this.name);

  factory Account.fromJSON(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJSON() => _$AccountToJson(this);

  @override
  List get props => [accountType, email, password, name];
}

enum AccountType { private, business}