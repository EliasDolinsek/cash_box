import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/data/core/datasources/templates/templates_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/templates/templates_remote_firebase_data_source.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class TemplatesRepositoryDefaultImpl implements TemplatesRepository {
  final Config config;
  final TemplatesLocalMobileDataSource localMobileDataSource;
  final TemplatesRemoteFirebaseDataSource remoteMobileFirebaseDataSource;

  TemplatesRepositoryDefaultImpl({
    @required this.config,
    @required this.localMobileDataSource,
    @required this.remoteMobileFirebaseDataSource,
  });

  @override
  Future<Either<Failure, EmptyData>> addTemplate(Template template) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.addType(template);
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
        return remoteMobileFirebaseDataSource;
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
  Future<Either<Failure, EmptyData>> removeTemplate(String id) async {
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
  Future<Either<Failure, EmptyData>> updateTemplate(
      String id, Template template) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.updateType(id, template);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }
}
