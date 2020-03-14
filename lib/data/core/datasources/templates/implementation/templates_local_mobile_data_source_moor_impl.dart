import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/templates/templates_local_mobile_data_source.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';

class TemplatesLocalMobileDataSourceMoorImpl implements TemplatesLocalMobileDataSource {

  final MoorAppDatabase database;

  TemplatesLocalMobileDataSourceMoorImpl(this.database);

  @override
  Future<void> addType(Template type) {
    // TODO: implement addType
    throw UnimplementedError();
  }

  @override
  Future<List<Template>> getTypes() {
    // TODO: implement getTypes
    throw UnimplementedError();
  }

  @override
  Future<void> removeType(String id) {
    // TODO: implement removeType
    throw UnimplementedError();
  }

  @override
  Future<void> updateType(String id, Template update) {
    // TODO: implement updateType
    throw UnimplementedError();
  }

}