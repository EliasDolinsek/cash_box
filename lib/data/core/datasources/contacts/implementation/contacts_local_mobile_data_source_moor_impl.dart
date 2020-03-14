import 'package:cash_box/data/core/datasources/contacts/contacts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/fields/fields_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'dart:convert';

import 'package:cash_box/domain/core/enteties/fields/field.dart';

class ContactsLocalMobileDataSourceMoorImpl implements ContactsLocalMobileDataSource {

  final FieldsLocalMobileDataSource fieldsDataSource;
  final MoorAppDatabase database;

  ContactsLocalMobileDataSourceMoorImpl(this.database, this.fieldsDataSource);

  @override
  Future<void> addType(Contact type) async {
    final contactsMoorData = contactsMoorDataFromContact(type);
    await database.addContact(contactsMoorData);
  }

  @override
  Future<List<Contact>> getTypes() async {
    final allContactsMoorData = await database.getAllContacts();
    final List<Contact> contacts = [];

    for(ContactsMoorData contactsMoorData in allContactsMoorData) {
      final List<String> fieldIDs = json.decode(contactsMoorData.fieldIDs).cast<String>();
      final fieldsOfContact = await fieldsDataSource.getFieldsWithIDs(fieldIDs);
      final contact = contactFromContactsMoorData(contactsMoorData, fieldsOfContact);
      contacts.add(contact);
    }

    return contacts;
  }

  @override
  Future<void> removeType(String id) async {
    await database.deleteContact(id);
  }

  @override
  Future<void> updateType(String id, Contact contact) async {
    final originalContact = await getContactByID(id);
    final fieldIDsAsList = originalContact.fields.map((e) => e.id).toList();
    await deleteAllFields(fieldIDsAsList);

    final update = Contact(id, fields: contact.fields);
    await addAllFields(update.fields);

    await database.updateContact(contactsMoorDataFromContact(update));
  }

  Future<Contact> getContactByID(String id) async {
    final contactsMoorData = await database.getContact(id);
    final fieldsIDsAsList = json.decode(contactsMoorData.fieldIDs).cast<String>();

    final fields = await fieldsDataSource.getFieldsWithIDs(fieldsIDsAsList);
    return contactFromContactsMoorData(contactsMoorData, fields);
  }

  Future addAllFields(List<Field> fields) async {
    for(Field field in fields){
      await fieldsDataSource.addType(field);
    }
  }

  Future deleteAllFields(List<String> fieldIDs) async {
    for(String fieldID in fieldIDs){
      await fieldsDataSource.removeType(fieldID);
    }
  }

}