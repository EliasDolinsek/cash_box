import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/datasources/datasource.dart';
import 'package:cash_box/data/datasources/templates/templates_local_mobile_data_source.dart';
import 'package:cash_box/data/datasources/templates/templates_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/datasources/templates/templates_remote_web_firebase_data_source.dart';
import 'package:cash_box/domain/enteties/template.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/templates_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class TemplatesRepositoryDefaultImpl implements TemplatesRepository {
  final Config config;
  final TemplatesLocalMobileDataSource localMobileDataSource;
  final TemplatesRemoteMobileFirebaseDataSource remoteMobileFirebaseDataSource;
  final TemplatesRemoteWebFirebaseDataSource remoteWebFirebaseDataSource;

  TemplatesRepositoryDefaultImpl(
      {@required this.config,
      @required this.localMobileDataSource,
      @required this.remoteMobileFirebaseDataSource,
      @required this.remoteWebFirebaseDataSource});

  @override
  Future<Either<Failure, EmptyData>> addTemplate(Template template) {
    // TODO: implement addTemplate
    throw UnimplementedError();
  }

  @override
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
  Future<Either<Failure, List<Template>>> getTemplates() async {
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
  Future<Either<Failure, EmptyData>> removeTemplate(String id) {
    // TODO: implement removeTemplate
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> updateTemplate(
      String id, Template template) {
    // TODO: implement updateTemplate
    throw UnimplementedError();
  }
}
