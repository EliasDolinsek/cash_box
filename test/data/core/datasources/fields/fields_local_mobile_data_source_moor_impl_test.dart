import 'package:cash_box/data/core/datasources/fields/implementation/fields_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';

import '../../../../fixtures/field_fixtures.dart';

void main(){

  MoorAppDatabase appDatabase;
  FieldsLocalMobileDataSourceMoorImpl dataSource;

  setUp((){
    appDatabase = MoorAppDatabase(VmDatabase.memory(logStatements: true));
    dataSource = FieldsLocalMobileDataSourceMoorImpl(appDatabase);
  });

  test("addType", () async {
    final field = fieldFixtures.first;
    await dataSource.addType(field);

    final result = await appDatabase.getField(field.id);

    expect(fieldFromFieldsMoorData(result), field);
  });

  test("removeType", () async {
    final field = fieldFixtures.first;
    await dataSource.addType(field);

    await dataSource.removeType(field.id);
    final result = await dataSource.getTypes();
    expect(result.length, 0);
  });

  test("updateType", () async {
    final field = fieldFixtures.first;
    await dataSource.addType(field);

    final update = Field(field.id, type: FieldType.file, description: "update", value: "local:update.png");
    await dataSource.updateType(field.id, update);

    final result = await dataSource.getTypes();
    expect(result.first, update);
  });

  test("getTypes", () async {
    final field = fieldFixtures.first;
    await dataSource.addType(field);

    final result = await dataSource.getTypes();
    expect(result, [field]);
  });

  tearDown(() async {
    await appDatabase.close();
  });
}