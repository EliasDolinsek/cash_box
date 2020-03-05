import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/datasources/buckets/buckets_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/datasources/buckets/buckets_remote_web_firebase_data_source.dart';
import 'package:cash_box/data/datasources/datasource.dart';
import 'package:cash_box/data/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/data/datasources/receipts/receipts_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/datasources/receipts/receipts_remote_web_firebase_data_source.dart';
import 'package:cash_box/data/repositories/repository.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/core/errors/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class BucketsRepositoryDefaultImpl implements BucketsRepository, Repository {
  final Config config;

  final BucketsLocalMobileDataSource bucketsLocalMobileDataSource;
  final BucketsRemoteMobileFirebaseDataSource
      bucketsRemoteMobileFirebaseDataSource;
  final BucketsRemoteWebFirebaseDataSource bucketsRemoteWebFirebaseDataSource;

  final ReceiptsLocalMobileDataSource receiptsLocalMobileDataSource;
  final ReceiptsRemoteMobileFirebaseDataSource
      receiptsRemoteMobileFirebaseDataSource;
  final ReceiptsRemoteWebFirebaseDataSource receiptsRemoteWebFirebaseDataSource;

  BucketsRepositoryDefaultImpl(
      {@required this.bucketsLocalMobileDataSource,
      @required this.bucketsRemoteMobileFirebaseDataSource,
      @required this.bucketsRemoteWebFirebaseDataSource,
      @required this.receiptsLocalMobileDataSource,
      @required this.receiptsRemoteMobileFirebaseDataSource,
      @required this.receiptsRemoteWebFirebaseDataSource,
      @required this.config});

  @override
  Future<Either<Failure, EmptyData>> addBucket(Bucket bucket) async {
    try {
      final dataSource = await this.bucketsDataSource;
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
      String bucketID, String receiptID) async {
    try {
      final dataSource = await this.receiptsDataSource;
    } on DataStorageLocationException {

    } on Exception {

    }
  }

  @override
  Future<Either<Failure, List<Bucket>>> getBuckets() async {
    try {
      final dataSource = await this.bucketsDataSource;
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
      final dataSource = await this.bucketsDataSource;
      await dataSource.removeType(id);
      return Right(EmptyData());
    } on DataStorageLocationException {
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
  Future<Either<Failure, EmptyData>> updateBucket(
      String id, Bucket bucket) async {
    try {
      final dataSource = await this.bucketsDataSource;
      await dataSource.updateType(id, bucket);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  Future<DataSource> get bucketsDataSource => dataSource;

  @override
  Future<DataSource> get dataSource async {
    final dataStorageLocation = await config.dataStorageLocation;
    switch (dataStorageLocation) {
      case DataStorageLocation.LOCAL_MOBILE:
        return bucketsLocalMobileDataSource;
      case DataStorageLocation.REMOTE_MOBILE_FIREBASE:
        return bucketsRemoteMobileFirebaseDataSource;
      case DataStorageLocation.REMOTE_WEB_FIREBASE:
        return bucketsRemoteWebFirebaseDataSource;
      default:
        throw new Exception(
            "Couldn't resolve data storage location for $dataStorageLocation");
    }
  }

  Future<DataSource> get receiptsDataSource async {
    final dataStorageLocation = await config.dataStorageLocation;
    switch(dataStorageLocation){
      case DataStorageLocation.LOCAL_MOBILE: return receiptsLocalMobileDataSource;
      case DataStorageLocation.REMOTE_MOBILE_FIREBASE: return receiptsRemoteMobileFirebaseDataSource;
      case DataStorageLocation.REMOTE_WEB_FIREBASE: return receiptsRemoteWebFirebaseDataSource;
      default: throw new Exception("Couldn't reslove data storage location for $dataStorageLocation");
    }
  }
}
