import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/data/core/datasources/tags/implementation/tags_remote_firebase_data_source_default_impl.dart';
import 'package:cash_box/data/core/datasources/tags/tags_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/tags/tags_remote_firebase_data_source.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/tags_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class TagsRepositoryDefaultImpl implements TagsRepository {
  final Config config;
  final TagsLocalMobileDataSource localMobileDataSource;
  final TagsRemoteFirebaseDataSource remoteFirebaseDataSource;

  TagsRepositoryDefaultImpl({
    @required this.config,
    @required this.localMobileDataSource,
    @required this.remoteFirebaseDataSource,
  });

  @override
  Future<Either<Failure, EmptyData>> addTag(Tag tag) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.addType(tag);
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
      case DataStorageLocation.REMOTE_FIREBASE:
        return remoteFirebaseDataSource;
      default:
        throw DataStorageLocationException();
    }
  }

  @override
  Future<Either<Failure, List<Tag>>> getTags() async {
    try {
      final dataSource = await this.dataSource;
      final templates = await dataSource.getTypes();
      return Right(templates);
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> removeTag(String id) async {
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
  Future<Either<Failure, EmptyData>> updateTag(String id, Tag update) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.updateType(id, update);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  void notifyUserIdChanged(String userId) async {
    final firebaseDataSource = remoteFirebaseDataSource;
    if(firebaseDataSource is TagsRemoteFirebaseDataSourceDefaultImpl){
      firebaseDataSource.userID = userId;
    }

    (await dataSource).clear();
  }
}
