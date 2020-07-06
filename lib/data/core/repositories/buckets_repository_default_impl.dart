import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/buckets/implementation/buckets_remote_firebase_data_source_default_impl.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/core/errors/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class BucketsRepositoryDefaultImpl implements BucketsRepository {
  final Config config;

  final BucketsLocalMobileDataSource bucketsLocalMobileDataSource;
  final BucketsRemoteFirebaseDataSource
      bucketsRemoteFirebaseDataSource;

  BucketsRepositoryDefaultImpl(
      {@required this.bucketsLocalMobileDataSource,
      @required this.bucketsRemoteFirebaseDataSource,
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
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> updateBucket(
      String id, Bucket bucket) async {
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
        return bucketsLocalMobileDataSource;
      case DataStorageLocation.REMOTE_FIREBASE:
        return bucketsRemoteFirebaseDataSource;
      default:

        throw DataStorageLocationException();
    }
  }

  @override
  void notifyUserIdChanged(String userId) async {
    final firebaseDataSource = bucketsRemoteFirebaseDataSource;
    if(firebaseDataSource is BucketsRemoteFirebaseDataSourceDefaultImpl){
      firebaseDataSource.userID = userId;
    }

    (await dataSource).clear();
  }
}
