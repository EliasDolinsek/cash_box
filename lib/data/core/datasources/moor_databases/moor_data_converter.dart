import 'dart:convert';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';

import 'moor_app_database.dart';

//
// Buckets
//

BucketsMoorData bucketsMoorDataFromBucket(Bucket bucket) {
  final receiptIDsAsString = json.encode(bucket.receiptsIDs);

  return BucketsMoorData(
    id: bucket.id,
    description: bucket.description,
    name: bucket.name,
    receiptsIDs: receiptIDsAsString,
  );
}

Bucket bucketFromBucketsMoorData(BucketsMoorData bucketsMoorData) {
  final receiptIDs = json.decode(bucketsMoorData.receiptsIDs).cast<String>();
  return Bucket(
    bucketsMoorData.id,
    name: bucketsMoorData.name,
    description: bucketsMoorData.description,
    receiptsIDs: receiptIDs,
  );
}

//
// Contacts
//

ContactsMoorData contactsMoorDataFromContact(Contact contact) {
  final fieldIDs = json.encode(contact.fields.map((f) => f.id).toList());

  return ContactsMoorData(id: contact.id, fieldIDs: fieldIDs);
}

Contact contactFromContactsMoorData(
    ContactsMoorData contactsMoorData, List<Field> fields) {
  return Contact(contactsMoorData.id, fields: fields);
}

//
// Fields
//

FieldsMoorData fieldsMoorDataFromField(Field field) {
  return FieldsMoorData(
      id: field.id,
      description: field.description,
      type: field.type.toString(),
      value: field.value.toString(),
      storageOnly: field.storageOnly);
}

Field fieldFromFieldsMoorData(FieldsMoorData fieldsMoorData) {
  final fieldType = fieldTypeFromString(fieldsMoorData.type);
  final value = valueFromFieldTypeAndString(fieldType, fieldsMoorData.value);
  return Field(
    fieldsMoorData.id,
    type: fieldType,
    description: fieldsMoorData.description,
    value: value,
    storageOnly: fieldsMoorData.storageOnly,
  );
}

dynamic valueFromFieldTypeAndString(FieldType fieldType, String data) {
  switch (fieldType) {
    case FieldType.text:
      return data;
    case FieldType.image:
      return data;
    case FieldType.file:
      return data;
    case FieldType.amount:
      return double.parse(data);
    case FieldType.date:
      return DateTime.parse(data);
  }
}

FieldType fieldTypeFromString(String type) {
  if (type == FieldType.file.toString()) {
    return FieldType.file;
  } else if (type == FieldType.image.toString()) {
    return FieldType.image;
  } else if (type == FieldType.date.toString()) {
    return FieldType.date;
  } else if (type == FieldType.amount.toString()) {
    return FieldType.amount;
  } else if (type == FieldType.text.toString()) {
    return FieldType.text;
  } else {
    throw new Exception("Couldn't resolve FieldType from String $type");
  }
}

//
// Tags
//

TagsMoorData tagsMoorDataFromTag(Tag tag) {
  return TagsMoorData(id: tag.id, name: tag.name, color: tag.color);
}

Tag tagFromTagsMoorData(TagsMoorData tagsMoorData) {
  return Tag(tagsMoorData.id,
      name: tagsMoorData.name, color: tagsMoorData.color);
}

//
// Templates
//

TemplatesMoorData templatesMoorDataFromTemplate(Template template) {
  final fieldIDsAsString = template.fields.map((e) => e.id).toList();
  return TemplatesMoorData(
      id: template.id,
      name: template.name,
      fields: json.encode(fieldIDsAsString));
}

Template templateFromTemplatesMoorData(
    TemplatesMoorData templatesMoorData, List<Field> fields) {
  return Template(templatesMoorData.id,
      name: templatesMoorData.name, fields: fields);
}

//
// Receipts
//
ReceiptsMoorData receiptsMoorDataFromReceipt(Receipt receipt) {
  final fieldIDsAsStringList = receipt.fields.map((e) => e.id).toList();
  return ReceiptsMoorData(
    id: receipt.id,
    type: receipt.type.toString(),
    creationDate: receipt.creationDate,
    fieldIDs: json.encode(fieldIDsAsStringList),
    tagIDs: json.encode(receipt.tagIDs),
  );
}

Receipt receiptFromReceiptsMoorData(ReceiptsMoorData data, List<Field> fields) {
  final receiptType = receiptTypeFromString(data.type);
  return Receipt(
    data.id,
    type: receiptType,
    creationDate: data.creationDate,
    fields: fields,
    tagIDs: json.decode(data.tagIDs).cast<String>(),
  );
}

ReceiptType receiptTypeFromString(String type) {
  if (type == ReceiptType.income.toString()) {
    return ReceiptType.income;
  } else if (type == ReceiptType.outcome.toString()) {
    return ReceiptType.outcome;
  } else {
    throw new Exception("Couldn't resolve ReceiptType from String $type");
  }
}
