import 'package:cash_box/data/core/datasources/fields/implementation/fields_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/templates/implementation/templates_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/templates/templates_local_mobile_data_source.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';

import '../../../../fixtures/field_fixtures.dart';
import '../../../../fixtures/templates_fixtures.dart';

void main() {
  MoorAppDatabase appDatabase;
  FieldsLocalMobileDataSourceMoorImpl fieldsDataSource;
  TemplatesLocalMobileDataSource templatesDataSource;

  setUp(() {
    appDatabase = MoorAppDatabase(VmDatabase.memory(logStatements: true));
    fieldsDataSource = FieldsLocalMobileDataSourceMoorImpl(appDatabase);
    templatesDataSource =
        TemplatesLocalMobileDataSourceMoorImpl(appDatabase, fieldsDataSource);
  });

  test("addType and getTypes", () async {
    final template = templateFixtures.first;
    await templatesDataSource.addType(template);

    final result = await templatesDataSource.getTypes();
    expect(result.first, template);
  });

  test("removeType", () async {
    final template = templateFixtures.first;
    await templatesDataSource.addType(template);

    await templatesDataSource.removeType(template.id);

    final result = await templatesDataSource.getTypes();
    expect(result.length, 0);
  });

  test("updateType", () async {
    final template = templateFixtures.first;
    await templatesDataSource.addType(template);

    final updatedTemplate =
        Template(template.id, name: "update", fields: fieldFixtures);

    await templatesDataSource.updateType(template.id, updatedTemplate);

    final result = await templatesDataSource.getTypes();
    expect(result.first, updatedTemplate);
  });
}
