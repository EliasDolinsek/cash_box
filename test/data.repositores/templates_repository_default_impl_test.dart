import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/repositories/templates_repository_default_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/templates_fixtures.dart';
import 'mocks/mocks.dart';

void main() {
  TemplatesRepositoryDefaultImpl repository;

  MockConfig config = MockConfig();
  MockTemplatesLocalMobileDataSource localMobileDataSource =
      MockTemplatesLocalMobileDataSource();
  MockTemplatesRemoteMobileFirebaseDataSource remoteMobileFirebaseDataSource =
      MockTemplatesRemoteMobileFirebaseDataSource();
  MockTemplatesRemoteWebFirebaseDataSource remoteWebFirebaseDataSource =
      MockTemplatesRemoteWebFirebaseDataSource();

  setUp(() {
    repository = TemplatesRepositoryDefaultImpl(
        config: config,
        localMobileDataSource: localMobileDataSource,
        remoteMobileFirebaseDataSource: remoteMobileFirebaseDataSource,
        remoteWebFirebaseDataSource: remoteWebFirebaseDataSource);
  });

  group("dataSource", (){
    test("should get the dataSource for dataStorageLocation = LOCAL_MOBILE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      final result = await repository.dataSource;
      expect(result, localMobileDataSource);
    });

    test("should get the dataSource for dataStorageLocation = REMOTE_MOBILE_FIREBASE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.REMOTE_MOBILE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, remoteMobileFirebaseDataSource);
    });

    test("should get the dataSource for dataStorageLocation = REMOTE_WEB_FIREBASE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.REMOTE_WEB_FIREBASE);
      final result = await repository.dataSource;
      expect(result, remoteWebFirebaseDataSource);
    });
  });

  group("getTemplates", (){
    test("should call the dataSource to get all templates", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(localMobileDataSource.getTypes()).thenAnswer((realInvocation) async => templateFixtures);

      final result = await repository.getTemplates();
      expect(result, Right(templateFixtures)); //NOT WORKING BECAUSE IT'S A LIST
      verify(localMobileDataSource.getTypes());
    });

    test("should call the dataSource to get all templates, but return a DataStorageLocationFailure when a DataStorageLcoationException gets thrown", () async {
      when(config.dataStorageLocation).thenThrow(DataStorageLocationException());

      verifyNoMoreInteractions(localMobileDataSource);
      final result = await repository.getTemplates();
      expect(result, Left(DataStorageLocationFailure())); //NOT WORKING BECAUSE IT'S A LIST
    });
  });
}
