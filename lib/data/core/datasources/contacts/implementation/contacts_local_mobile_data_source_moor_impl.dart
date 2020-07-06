import 'package:cash_box/data/core/datasources/contacts/contacts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/fields/fields_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'dart:convert';

class ContactsLocalMobileDataSourceMoorImpl implements ContactsLocalMobileDataSource {

  final FieldsLocalMobileDataSource fieldsDataSource;
  final MoorAppDatabase database;

  ContactsLocalMobileDataSourceMoorImpl(this.database, this.fieldsDataSource);

  @override
  Future<void> addType(Contact type) async {
    final contactsMoorData = contactsMoorDataFromContact(type);
    await fieldsDataSource.addAllFields(type.fields);
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
    Contact contact = await _getContactByID(id);
    final fieldIDsAsList = contact.fields.map((e) => e.id).toList();

    await fieldsDataSource.removeAllFieldsWithIDs(fieldIDsAsList);
    await database.deleteContact(id);
  }

  @override
  Future<void> updateType(String id, Contact contact) async {
    final originalContact = await _getContactByID(id);
    final fieldIDsAsList = originalContact.fields.map((e) => e.id).toList();
    await fieldsDataSource.removeAllFieldsWithIDs(fieldIDsAsList);

    final update = Contact(id, fields: contact.fields, name: contact.name);
    await fieldsDataSource.addAllFields(update.fields);

    await database.updateContact(contactsMoorDataFromContact(update));
  }

  Future<Contact> _getContactByID(String id) async {
    final contactsMoorData = await database.getContact(id);
    final fieldsIDsAsList = json.decode(contactsMoorData.fieldIDs).cast<String>();

    final fields = await fieldsDataSource.getFieldsWithIDs(fieldsIDsAsList);
    return contactFromContactsMoorData(contactsMoorData, fields);
  }

  @override
  void clear() {
    // Nothing to clear
  }

}