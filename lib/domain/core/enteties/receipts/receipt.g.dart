// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) {
  return Receipt(
    json['id'] as String,
    type: _$enumDecode(_$ReceiptTypeEnumMap, json['type']),
    creationDate: DateTime.parse(json['creationDate'] as String),
    fields: (json['fields'] as List)
        .map((e) => Field.fromJson(e as Map<String, dynamic>))
        .toList(),
    tagIDs: (json['tagIDs'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$ReceiptTypeEnumMap[instance.type],
      'creationDate': instance.creationDate.toIso8601String(),
      'fields': instance.fields.map((e) => e.toJson()).toList(),
      'tagIDs': instance.tagIDs,
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

const _$ReceiptTypeEnumMap = {
  ReceiptType.income: 'income',
  ReceiptType.outcome: 'outcome'
};
