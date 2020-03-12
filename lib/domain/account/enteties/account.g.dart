// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    userID: json['userID'] as String,
    signInSource: _$enumDecode(_$SignInSourceEnumMap, json['signInSource']),
    accountType: _$enumDecode(_$AccountTypeEnumMap, json['accountType']),
    email: json['email'] as String,
    password: json['password'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'signInSource': _$SignInSourceEnumMap[instance.signInSource],
      'accountType': _$AccountTypeEnumMap[instance.accountType],
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'userID': instance.userID,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$SignInSourceEnumMap = {
  SignInSource.firebase: 'firebase',
};

const _$AccountTypeEnumMap = {
  AccountType.private: 'private',
  AccountType.business: 'business',
};
