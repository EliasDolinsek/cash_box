import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/datasources/buckets/buckets_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/datasources/buckets/buckets_remote_web_firebase_data_source.dart';
import 'package:cash_box/data/datasources/datasource.dart';
import 'package:cash_box/data/repositories/repository.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/core/errors/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class BucketsRepositoryDefaultImpl implements BucketsRepository, Repository {
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
  Future<Either<Failure, EmptyData>> addBucket(Bucket bucket) async {
    try {
      final dataSource = await this.dataSource;
      dataSource.addType(bucket);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> addReceipt(
      String bucketID, String receiptID) {
    // TODO: implement addReceipt
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Bucket>>> getBuckets() async {
    try {
      final dataSource = await this.dataSource;
      final buckets = await dataSource.getTypes();
      return Right(buckets);
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> removeBucket(String id) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.removeType(id);
      return Right(EmptyData());
    } on DataStorageLocationException{
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> removeReceipt(
      String bucketID, String receiptID) {
    // TODO: implement removeReceipt
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> updateBucket(String id, Bucket bucket) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.updateType(id, bucket);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<DataSource> get dataSource async {
    final dataStorageLocation = await config.dataStorageLocation;
    switch (dataStorageLocation) {
      case DataStorageLocation.LOCAL_MOBILE:
        return localMobileDataSource;
      case DataStorageLocation.REMOTE_MOBILE_FIREBASE:
        return remoteMobileFirebaseDataSource;
      case DataStorageLocation.REMOTE_WEB_FIREBASE:
        return remoteWebFirebaseDataSource;
      default:
        throw new Exception(
            "Couldn't resolve data storage location for ${config.dataStorageLocation}");
    }
  }
}
