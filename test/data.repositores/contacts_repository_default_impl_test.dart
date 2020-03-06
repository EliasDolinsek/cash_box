import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/repositories/contacts_repository_default_impl.dart';
import 'package:cash_box/domain/repositories/contacts_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/contact_fixtures.dart';
import 'mocks/mocks.dart';

void main() {
  ContactsRepositoryDefaultImpl repository;

  MockConfig config = MockConfig();

  MockContactsLocalMobileDataSource localMobileDataSource =
      MockContactsLocalMobileDataSource();
  MockContactsRemoteMobileFirebaseDataSource remoteMobileFirebaseDataSource =
      MockContactsRemoteMobileFirebaseDataSource();
  MockContactsRemoteWebFirebaseDataSource remoteWebFirebaseDataSource =
      MockContactsRemoteWebFirebaseDataSource();

  setUp(() {
    repository = ContactsRepositoryDefaultImpl(
        config: config,
        localMobileDataSource: localMobileDataSource,
        remoteMobileFirebaseDataSource: remoteMobileFirebaseDataSource,
        remoteWebFirebaseDataSource: remoteWebFirebaseDataSource);
  });

  group("dataSource", () {
    test("should get the dataSource for dataStorageLocation = LOCAL_MOBILE",
        () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      final result = await repository.dataSource;
      expect(result, localMobileDataSource);
    });

    test(
        "should get the dataSource for dataStorageLocation = REMOTE_MOBILE_FIREBASE",
        () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.REMOTE_MOBILE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, remoteMobileFirebaseDataSource);
    });

    test(
        "should get the dataSource for dataStorageLocation = REMOTE_WEB_FIREBASE",
        () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.REMOTE_WEB_FIREBASE);
      final result = await repository.dataSource;
      expect(result, remoteWebFirebaseDataSource);
    });
  });

  group("addContact", () {
    final testContact = contactFixtures.first;
    test("should call the dataSource to add a contact", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.addType(any))
          .thenAnswer((_) async => Right(EmptyData()));

      final result = await repository.addContact(testContact);
      expect(result, Right(EmptyData()));
      verify(repository.addContact(testContact));
    });

    test(
        "should call the dataSource to add a contact and return a DataStorageLocationFailure when an DataStorageLocationException gets thrown",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());

      final result = await repository.addContact(testContact);
      expect(result, Left(DataStorageLocationFailure()));

      verify(repository.addContact(testContact));
      verifyNever(localMobileDataSource.addType(testContact));
    });
  });
}
