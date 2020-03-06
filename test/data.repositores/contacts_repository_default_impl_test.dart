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

  group("getContacts", () {
    test("should call the dataSource to get all contacts", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.getTypes())
          .thenAnswer((_) async => contactFixtures);

      final result = await repository.getContacts();
      expect(result, Right(contactFixtures));
      verify(
          localMobileDataSource.getTypes()); //NOT WORKING BECAUSE IT'S A LIST
    });

    test(
        "should call the dataSource to get all contacts and return a DataStorageLocationFailure when an DataStorageLocationException gets thrown",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());

      final result = await repository.getContacts();
      expect(result, Left(DataStorageLocationFailure()));
      verifyNever(localMobileDataSource.getTypes());
    });
  });

  group("removeContacts", () {
    final testID = "abc-123";

    test("should call the dataSource to remove a contact", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.removeType(any))
          .thenAnswer((_) async => Right(EmptyData()));

      final result = await repository.removeContact(testID);
      expect(result, Right(EmptyData()));
      verify(localMobileDataSource.removeType(testID));
    });

    test(
        "should call the dataSource to remove a contact, but return a DataStorageLocationFailure when an DataStorageLocationException gets thrown",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());

      final result = await repository.removeContact(testID);
      expect(result, Left(DataStorageLocationFailure()));
      verifyNever(localMobileDataSource.removeType(testID));
    });
  });

  group("updateContact", () {
    final testID = "abc-123";
    final testContact = contactFixtures.first;

    test("should call the dataSource to update a contact", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.updateType(any, any))
          .thenAnswer((_) async => Right(EmptyData()));

      final result = await repository.updateContact(testID, testContact);
      expect(result, Right(EmptyData()));
      verify(localMobileDataSource.updateType(testID, testContact));
    });

    test("should call the dataSource to update a contact", () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());

      verifyNoMoreInteractions(localMobileDataSource);
      final result = await repository.updateContact(testID, testContact);
      expect(result, Left(DataStorageLocationFailure()));
    });
  });
}
