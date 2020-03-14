import 'package:cash_box/data/core/datasources/contacts/implementation/contacts_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/fields/implementation/fields_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';

import '../../../../fixtures/contact_fixtures.dart';

void main(){

  MoorAppDatabase appDatabase;
  ContactsLocalMobileDataSourceMoorImpl dataSource;
  FieldsLocalMobileDataSourceMoorImpl fieldsDataSource;

  setUp((){
    appDatabase = MoorAppDatabase(VmDatabase.memory(logStatements: true));
    fieldsDataSource = FieldsLocalMobileDataSourceMoorImpl(appDatabase);
    dataSource = ContactsLocalMobileDataSourceMoorImpl(appDatabase, fieldsDataSource);
  });

  test("addType", () async {
    final contact = contactFixtures.first;
    await dataSource.addType(contact);

    final result = await appDatabase.getContact(contact.id);

    expect(result, contactsMoorDataFromContact(contact));
  });

  test("getTypes", () async {
    await dataSource.addType(contactFixtures[0]);
    await dataSource.addType(contactFixtures[1]);

    final result = await dataSource.getTypes();

    expect(result, [contactFixtures[0], contactFixtures[1]]); //Not working because it's a list
  });

  test("removeType", () async {
    final contact = contactFixtures[0];
    await dataSource.addType(contact);

    await dataSource.removeType(contact.id);

    final result = await dataSource.getTypes();
    expect(result.length, 0);
  });

  test("updateType", () async {
    final contact = contactFixtures.first;

    await dataSource.addType(contact);
    final update = contactFixtures[1];
    await dataSource.updateType(contact.id, update);

    final expectedResult = Contact(contact.id, fields: update.fields);
    final result = await dataSource.getTypes();

    print(result.first.toJson());
    print(expectedResult.toJson());

    expect(result.first, expectedResult);
  });
}