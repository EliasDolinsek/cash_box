import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_remote_web_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/domain/core/enteties/contact.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class ContactsRepositoryDefaultImpl implements ContactsRepository {
  final Config config;

  final ContactsLocalMobileDataSource localMobileDataSource;
  final ContactsRemoteMobileFirebaseDataSource remoteMobileFirebaseDataSource;
  final ContactsRemoteWebFirebaseDataSource remoteWebFirebaseDataSource;

  ContactsRepositoryDefaultImpl(
      {@required this.config,
      @required this.localMobileDataSource,
      @required this.remoteMobileFirebaseDataSource,
      @required this.remoteWebFirebaseDataSource});

  @override
  Future<Either<Failure, EmptyData>> addContact(Contact contact) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.addType(contact);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getContacts() async {
    try {
      final dataSource = await this.dataSource;
      final contacts = await dataSource.getTypes();
      return Right(contacts);
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> removeContact(String id) async {
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
  Future<Either<Failure, EmptyData>> updateContact(String id, Contact update) async {
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
}
