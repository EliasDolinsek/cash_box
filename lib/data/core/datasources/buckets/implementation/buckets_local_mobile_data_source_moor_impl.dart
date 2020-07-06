import 'package:cash_box/data/core/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';

class BucketsLocalMobileDataSourceMoorImpl
    implements BucketsLocalMobileDataSource {

  final MoorAppDatabase database;

  BucketsLocalMobileDataSourceMoorImpl(this.database);

  @override
  Future<void> addType(Bucket type) {
    final moorBucketData = bucketsMoorDataFromBucket(type);
    return database.addBucket(moorBucketData);
  }

  @override
  Future<List<Bucket>> getTypes() async {
    final moorBucketData = await database.getAllBuckets();
    return moorBucketData.map((e) => bucketFromBucketsMoorData(e)).toList();
  }

  @override
  Future<void> removeType(String id) {
    return database.deleteBucket(id);
  }

  @override
  Future<void> updateType(id, Bucket bucket) {
    final update = Bucket(id,
        name: bucket.name,
        description: bucket.description,
        receiptsIDs: bucket.receiptsIDs);

    return database.updateBucket(bucketsMoorDataFromBucket(update));
  }

  @override
  void clear() {
    // Noting to clear
  }
}
