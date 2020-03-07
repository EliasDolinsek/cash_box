import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/datasources/datasource.dart';
import 'package:cash_box/data/datasources/tags/tags_local_mobile_data_source.dart';
import 'package:cash_box/data/datasources/tags/tags_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/datasources/tags/tags_remote_web_firebase_datasource.dart';
import 'package:cash_box/domain/enteties/tag.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/tags_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class TagsRepositoryDefaultImpl implements TagsRepository {
  final Config config;
  final TagsLocalMobileDataSource localMobileDataSource;
  final TagsRemoteMobileFirebaseDataSource remoteMobileFirebaseDataSource;
  final TagsRemoteWebFirebaseDataSource remoteWebFirebaseDataSource;

  TagsRepositoryDefaultImpl(
      {@required this.config,
      @required this.localMobileDataSource,
      @required this.remoteMobileFirebaseDataSource,
      @required this.remoteWebFirebaseDataSource});

  @override
  Future<Either<Failure, EmptyData>> addTag(Tag tag) {
    // TODO: implement addTag
    throw UnimplementedError();
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
        throw DataStorageLocationException();
    }
  }


  @override
  Future<Either<Failure, List<Tag>>> getTags() {
    // TODO: implement getTags
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> removeTag(String id) {
    // TODO: implement removeTag
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> updateTag(String id, Tag update) {
    // TODO: implement updateTag
    throw UnimplementedError();
  }
}
