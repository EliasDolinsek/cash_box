import 'package:cash_box/data/core/datasources/contacts/contacts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';

class ContactsLocalMobileDataSourceMoorImpl implements ContactsLocalMobileDataSource {

  final MoorAppDatabase database;

  ContactsLocalMobileDataSourceMoorImpl(this.database);

  @override
  Future<void> addType(Contact type) {
    // TODO: implement addType
    throw UnimplementedError();
  }

  @override
  Future<List<Contact>> getTypes() {
    // TODO: implement getTypes
    throw UnimplementedError();
  }

  @override
  Future<void> removeType(String id) {
    // TODO: implement removeType
    throw UnimplementedError();
  }

  @override
  Future<void> updateType(String id, Contact update) {
    // TODO: implement updateType
    throw UnimplementedError();
  }

}