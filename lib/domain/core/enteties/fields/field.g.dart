// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Field _$FieldFromJson(Map<String, dynamic> json) {
  return Field(
    json['id'] as String,
    type: _$enumDecode(_$FieldTypeEnumMap, json['type']),
    description: json['description'] as String,
    value: json['value'],
    storageOnly: json['storageOnly'] as bool,
  );
}

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'id': instance.id,
      'storageOnly': instance.storageOnly,
      'type': _$FieldTypeEnumMap[instance.type],
      'description': instance.description,
      'value': instance.value,
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

const _$FieldTypeEnumMap = {
  FieldType.amount: 'amount',
  FieldType.date: 'date',
  FieldType.image: 'image',
  FieldType.text: 'text',
  FieldType.file: 'file',
};
