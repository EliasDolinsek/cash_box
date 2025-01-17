import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_app_database.g.dart';

class BucketsMoor extends Table {
  TextColumn get id => text()();

  TextColumn get description => text().withDefault(Constant(""))();

  TextColumn get name => text().withDefault(Constant(""))();

  TextColumn get receiptsIDs => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

class ContactsMoor extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().withDefault(Constant(""))();

  TextColumn get fieldIDs => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

class FieldsMoor extends Table {
  TextColumn get id => text()();

  TextColumn get description => text().withDefault(Constant(""))();

  TextColumn get type => text().withDefault(Constant(""))();

  TextColumn get value => text().withDefault(Constant(""))();

  BoolColumn get storageOnly => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

class ReceiptsMoor extends Table {
  TextColumn get id => text()();

  TextColumn get type => text().withDefault(Constant(""))();

  DateTimeColumn get creationDate => dateTime()();

  TextColumn get fieldIDs => text().withDefault(Constant(""))();

  TextColumn get tagIDs => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

class TagsMoor extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().withDefault(Constant(""))();

  TextColumn get color => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

class TemplatesMoor extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().withDefault(Constant(""))();

  TextColumn get fields => text().withDefault(Constant(""))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [
  BucketsMoor,
  ContactsMoor,
  FieldsMoor,
  ReceiptsMoor,
  TagsMoor,
  TemplatesMoor
])
class MoorAppDatabase extends _$MoorAppDatabase {
  MoorAppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  //
  // Buckets
  //

  Future addBucket(BucketsMoorData bucket) => into(bucketsMoor).insert(bucket);

  Future<List<BucketsMoorData>> getAllBuckets() => select(bucketsMoor).get();

  Future<BucketsMoorData> getBucket(String id) async {
    final selectStatement = select(bucketsMoor)
      ..where((tbl) => tbl.id.equals(id));
    return (await selectStatement.get()).first;
  }

  Future deleteBucket(String id) async =>
      delete(bucketsMoor).delete(await getBucket(id));

  Future updateBucket(BucketsMoorData bucket) =>
      update(bucketsMoor).replace(bucket);

  //
  // Contacts
  //

  Future addContact(ContactsMoorData contact) =>
      into(contactsMoor).insert(contact);

  Future<List<ContactsMoorData>> getAllContacts() => select(contactsMoor).get();

  Future<ContactsMoorData> getContact(String id) async {
    final selectStatement = select(contactsMoor)
      ..where((tbl) => tbl.id.equals(id));
    return (await selectStatement.get()).first;
  }

  Future deleteContact(String id) async =>
      delete(contactsMoor).delete(await getContact(id));

  Future updateContact(ContactsMoorData contact) =>
      update(contactsMoor).replace(contact);

  //
  // Fields
  //

  Future addField(FieldsMoorData field) => into(fieldsMoor).insert(field);

  Future<List<FieldsMoorData>> getAllFields() => select(fieldsMoor).get();

  Future<FieldsMoorData> getField(String id) async {
    final selectStatement = select(fieldsMoor)
      ..where((tbl) => tbl.id.equals(id));
    return (await selectStatement.get()).first;
  }

  Future deleteField(String id) async =>
      delete(fieldsMoor).delete(await getField(id));

  Future updateField(FieldsMoorData field) => update(fieldsMoor).replace(field);

  //
  // Receipts
  //

  Future addReceipt(ReceiptsMoorData receipt) =>
      into(receiptsMoor).insert(receipt);

  Future<List<ReceiptsMoorData>> getAllReceipts() => select(receiptsMoor).get();

  Future<ReceiptsMoorData> getReceipt(String id) async {
    final selectStatement = select(receiptsMoor)
      ..where((tbl) => tbl.id.equals(id));
    return (await selectStatement.get()).first;
  }

  Future deleteReceipt(String id) async =>
      delete(receiptsMoor).delete(await getReceipt(id));

  Future updateReceipt(ReceiptsMoorData receipt) =>
      update(receiptsMoor).replace(receipt);

  Future<List<ReceiptsMoorData>> getReceiptsInReceiptMonth(
      ReceiptMonth receiptMonth) async {
    final selectStatement = select(receiptsMoor)
      ..where((tbl) => tbl.creationDate.month.equals(receiptMonth.monthAsInt))
      ..where((tbl) => tbl.creationDate.year.equals(receiptMonth.yearAsInt));

    return selectStatement.get();
  }

  //
  // Tags
  //

  Future addTag(TagsMoorData tag) => into(tagsMoor).insert(tag);

  Future<List<TagsMoorData>> getAllTags() => select(tagsMoor).get();

  Future<TagsMoorData> getTag(String id) async {
    final selectStatement = select(tagsMoor)..where((tbl) => tbl.id.equals(id));
    return (await selectStatement.get()).first;
  }

  Future deleteTag(String id) async =>
      delete(tagsMoor).delete(await getTag(id));

  Future updateTag(TagsMoorData tag) => update(tagsMoor).replace(tag);

  //
  // Templates
  //

  Future addTemplate(TemplatesMoorData template) =>
      into(templatesMoor).insert(template);

  Future<List<TemplatesMoorData>> getAllTemplates() =>
      select(templatesMoor).get();

  Future<TemplatesMoorData> getTemplate(String id) async {
    final selectStatement = select(templatesMoor)
      ..where((tbl) => tbl.id.equals(id));
    return (await selectStatement.get()).first;
  }

  Future deleteTemplate(String id) async =>
      delete(templatesMoor).delete(await getTemplate(id));

  Future updateTemplate(TemplatesMoorData template) =>
      update(templatesMoor).replace(template);
}
