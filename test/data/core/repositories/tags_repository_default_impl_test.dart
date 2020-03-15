import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/repositories/tags_repository_default_impl.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/tag_ids_fixtures.dart';
import 'mocks/mocks.dart';

void main() {
  TagsRepositoryDefaultImpl repository;

  MockConfig config = MockConfig();
  MockTagsLocalMobileDataSource localMobileDataSource =
      MockTagsLocalMobileDataSource();
  MockTagsRemoteFirebaseDataSource remoteFirebaseDataSource =
      MockTagsRemoteFirebaseDataSource();

  setUp(() {
    repository = TagsRepositoryDefaultImpl(
      config: config,
      localMobileDataSource: localMobileDataSource,
      remoteFirebaseDataSource: remoteFirebaseDataSource,
    );
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
          .thenAnswer((_) async => DataStorageLocation.REMOTE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, remoteFirebaseDataSource);
    });

    test(
        "should get the dataSource for dataStorageLocation = REMOTE_WEB_FIREBASE",
        () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.REMOTE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, remoteFirebaseDataSource);
    });
  });

  group("addTag", () {
    final testTag = tagFixtures.first;

    test("should call the dataSource to add a tag", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.addType(any))
          .thenAnswer((realInvocation) async => Right(EmptyData()));

      final result = await repository.addTag(testTag);
      expect(result, Right(EmptyData()));
      verify(localMobileDataSource.addType(testTag));
    });

    test(
        "should call the dataSource to add a tag, but return a DataStorageLocationFailure when a DataStorageLcoationException gets thrown",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());

      verifyNoMoreInteractions(localMobileDataSource);
      final result = await repository.addTag(testTag);
      expect(result, Left(DataStorageLocationFailure()));
    });
  });

  group("getTags", () {
    test("should call the dataSource to get all tags", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.getTypes())
          .thenAnswer((realInvocation) async => tagFixtures);

      final result = await repository.getTags();
      expect(result, Right(tagFixtures)); //NOT WORKING BECAUSE IT'S A LIST
      verify(localMobileDataSource.getTypes());
    });

    test(
        "should call the dataSource to get all tags, but return a DataStorageLocationFailure when a DataStorageLcoationException gets thrown",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());

      verifyNoMoreInteractions(localMobileDataSource);
      final result = await repository.getTags();
      expect(result, Left(DataStorageLocationFailure()));
    });
  });

  group("removeTag", () {
    final testID = "abc-123";

    test("should call the dataSource to remove a tag", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.removeType(any))
          .thenAnswer((realInvocation) async => null);

      final result = await repository.removeTag(testID);
      expect(result, Right(EmptyData()));
      verify(localMobileDataSource.removeType(testID));
    });

    test(
        "should call the dataSource to remove a tag, but return a DataStorageLocationFailure when a DataStorageLcoationException gets thrown",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());

      verifyNoMoreInteractions(localMobileDataSource);
      final result = await repository.removeTag(testID);
      expect(result, Left(DataStorageLocationFailure()));
    });
  });

  group("updateTag", () {
    final testID = "abc-123";
    final testTag = tagFixtures.first;

    test("should call the dataSource to remove a tag", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.updateType(any, any))
          .thenAnswer((_) async => null);

      final result = await repository.updateTag(testID, testTag);
      expect(result, Right(EmptyData()));
      verify(localMobileDataSource.updateType(testID, testTag));
    });

    test(
        "should call the dataSource to remove a tag, but return a DataStorageLocationFailure when a DataStorageLcoationException gets thrown",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());

      verifyNoMoreInteractions(localMobileDataSource);
      final result = await repository.updateTag(testID, testTag);
      expect(result, Left(DataStorageLocationFailure()));
    });
  });
}
