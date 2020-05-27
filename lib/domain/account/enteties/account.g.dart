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
    appPassword: json['appPassword'] as String,
    name: json['name'] as String,
    currencyCode: json['currencyCode'] as String,
    subscriptionInfo: SubscriptionInfo.fromJson(
        json['subscriptionInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'signInSource': _$SignInSourceEnumMap[instance.signInSource],
      'accountType': _$AccountTypeEnumMap[instance.accountType],
      'email': instance.email,
      'appPassword': instance.appPassword,
      'name': instance.name,
      'userID': instance.userID,
      'currencyCode': instance.currencyCode,
      'subscriptionInfo': instance.subscriptionInfo.toJson(),
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
