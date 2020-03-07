import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/repositories/tags_repository_default_impl.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/tag_ids_fixtures.dart';
import 'mocks/mocks.dart';

void main() {
  TagsRepositoryDefaultImpl repository;

  MockConfig config = MockConfig();
  MockTagsLocalMobileDataSource localMobileDataSource =
      MockTagsLocalMobileDataSource();
  MockTagsRemoteMobileFirebaseDataSource remoteMobileFirebaseDataSource =
      MockTagsRemoteMobileFirebaseDataSource();
  MockTagsRemoteWebFirebaseDataSource remoteWebFirebaseDataSource =
      MockTagsRemoteWebFirebaseDataSource();

  setUp(() {
    repository = TagsRepositoryDefaultImpl(
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

  group("addTag", (){

    final testTag = tagFixtures.first;

    test("should call the dataSource to add a tag", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.addType(any)).thenAnswer((realInvocation) async => Right(EmptyData()));

      final result = await repository.addTag(testTag);
      expect(result, Right(EmptyData()));
      verify(localMobileDataSource.addType(testTag));
    });

    test("should call the dataSource to add a template, but return a DataStorageLocationFailure when a DataStorageLcoationException gets thrown", () async {
      when(config.dataStorageLocation).thenThrow(DataStorageLocationException());

      verifyNoMoreInteractions(localMobileDataSource);
      final result = await repository.addTag(testTag);
      expect(result, Left(DataStorageLocationFailure()));
    });
  });
}
