// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionInfo _$SubscriptionInfoFromJson(Map<String, dynamic> json) {
  return SubscriptionInfo(
    subscriptionType:
        _$enumDecode(_$SubscriptionTypeEnumMap, json['subscriptionType']),
    purchaseDate: DateTime.parse(json['purchaseDate'] as String),
  );
}

Map<String, dynamic> _$SubscriptionInfoToJson(SubscriptionInfo instance) =>
    <String, dynamic>{
      'subscriptionType': _$SubscriptionTypeEnumMap[instance.subscriptionType],
      'purchaseDate': instance.purchaseDate.toIso8601String(),
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

const _$SubscriptionTypeEnumMap = {
  SubscriptionType.personal_free: 'personal_free',
  SubscriptionType.business_free: 'business_free',
  SubscriptionType.personal_pro: 'personal_pro',
  SubscriptionType.business_pro: 'business_pro',
};
