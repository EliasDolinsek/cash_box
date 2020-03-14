// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bucket _$BucketFromJson(Map<String, dynamic> json) {
  return Bucket(
    json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    receiptsIDs: (json['receiptsIDs'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$BucketToJson(Bucket instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'receiptsIDs': instance.receiptsIDs,
    };
