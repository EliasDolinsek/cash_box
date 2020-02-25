import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/datasources/buckets/buckets_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/datasources/buckets/buckets_remote_web_firebase_data_source.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class BucketsRepositoryDefaultImpl implements BucketsRepository {
  final BucketsLocalMobileDataSource localMobileDataSource;
  final BucketsRemoteMobileFirebaseDataSource remoteMobileFirebaseDataSource;
  final BucketsRemoteWebFirebaseDataSource remoteWebFirebaseDataSource;
  final Config config;

  BucketsRepositoryDefaultImpl(
      {@required this.localMobileDataSource,
      @required this.remoteMobileFirebaseDataSource,
      @required this.remoteWebFirebaseDataSource,
      @required this.config});

  @override
  Future<Either<Failure, EmptyData>> addBucket(Bucket bucket) {
    // TODO: implement addBucket
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> addReceipt(
      String bucketID, String receiptID) {
    // TODO: implement addReceipt
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Bucket>>> getBuckets() {
    // TODO: implement getBuckets
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> removeBucket(String id) {
    // TODO: implement removeBucket
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> removeReceipt(
      String bucketID, String receiptID) {
    // TODO: implement removeReceipt
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> updateBucket(String id, Bucket bucket) {
    // TODO: implement updateBucket
    throw UnimplementedError();
  }
}
