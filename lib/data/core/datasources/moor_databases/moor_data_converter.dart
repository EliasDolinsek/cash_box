import 'dart:convert';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';

import 'moor_app_database.dart';

BucketsMoorData bucketsMoorDataFromBucket(Bucket bucket) {
  final receiptIDsAsString = json.encode(bucket.receiptsIDs);

  return BucketsMoorData(
    id: bucket.id,
    description: bucket.description,
    name: bucket.name,
    receiptsIDs: receiptIDsAsString,
  );
}

Bucket bucketFromBucketsMoorData(BucketsMoorData bucketsMoorData) {
  final receiptIDs = json.decode(bucketsMoorData.receiptsIDs).cast<String>();
  return Bucket(
    bucketsMoorData.id,
    name: bucketsMoorData.name,
    description: bucketsMoorData.description,
    receiptsIDs: receiptIDs,
  );
}
