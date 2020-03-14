import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/tags/implementation/tags_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';

import '../../../../fixtures/tag_ids_fixtures.dart';

void main() {
  MoorAppDatabase database;
  TagsLocalMobileDataSourceMoorImpl dataSource;

  setUp(() {
    database = MoorAppDatabase(VmDatabase.memory(logStatements: true));
    dataSource = TagsLocalMobileDataSourceMoorImpl(database);
  });

  test("addType and getTypes", () async {
    final tag = tagFixtures.first;
    await dataSource.addType(tag);

    final result = await dataSource.getTypes();
    expect(result.first, tag);
  });

  test("removeType", () async {
    final tag = tagFixtures.first;
    await dataSource.addType(tag);
    await dataSource.addType(tagFixtures[1]);

    await dataSource.removeType(tag.id);

    final result = await dataSource.getTypes();
    expect(result.first, tagFixtures[1]);
  });

  test("updateType", () async {
    final tag = tagFixtures.first;
    await dataSource.addType(tag);

    final update = Tag(null, name: "update", color: "update");
    await dataSource.updateType(tag.id, update);

    final expectedResult = Tag(tag.id, name: update.name, color: update.color);
    final result = await dataSource.getTypes();
    expect(result.first, expectedResult);
  });

  tearDown(() async {
    await database.close();
  });
}
