import 'package:cash_box/data/core/datasources/buckets/implementation/buckets_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';

import '../../../../fixtures/buckets_fixtures.dart';

void main(){
  MoorAppDatabase appDatabase;
  BucketsLocalMobileDataSourceMoorImpl dataSource;
  
  setUp((){
    appDatabase = MoorAppDatabase(VmDatabase.memory(logStatements: true));
    dataSource = BucketsLocalMobileDataSourceMoorImpl(appDatabase);
  });

  test("addType", () async {
    final bucket = bucketFixtures.first;
    await dataSource.addType(bucket);

    final result = await appDatabase.getBucket(bucket.id);

    expect(bucketFromBucketsMoorData(result), bucket);
  });

  test("removeType", () async {
    final bucket = bucketFixtures.first;
    await dataSource.addType(bucket);
    await dataSource.removeType(bucket.id);
    final result = await dataSource.getTypes();
    expect(result.length, 0);
  });

  test("updateType", () async {
    final bucket = bucketFixtures.first;
    await dataSource.addType(bucket);

    final update = Bucket(bucket.id, name: "update", description: "update", receiptsIDs: ["update"]);
    await dataSource.updateType(bucket.id, update);

    final result = await dataSource.getTypes();
    expect(result.first, update);
  });

  test("getTypes", () async {
    final bucket = bucketFixtures.first;
    await dataSource.addType(bucket);

    final result = await dataSource.getTypes();
    expect(result, [bucket]);
  });

  tearDown(() async {
    await appDatabase.close();
  });
}