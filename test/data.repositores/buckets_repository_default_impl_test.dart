import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/repositories/buckets_repository_default_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mocks.dart';

void main() {
  BucketsRepositoryDefaultImpl repository;

  MockBucketsLocalMobileDataSource localMobileDataSource =
      MockBucketsLocalMobileDataSource();
  MockBucketsRemoteMobileFirebaseDataSource remoteMobileFirebaseDataSource =
      MockBucketsRemoteMobileFirebaseDataSource();
  MockBucketsRemoteWebFirebaseDataSource remoteWebFirebaseDataSource =
      MockBucketsRemoteWebFirebaseDataSource();
  MockConfig config = MockConfig();

  setUp(() {
    repository = BucketsRepositoryDefaultImpl(
        localMobileDataSource: localMobileDataSource,
        remoteMobileFirebaseDataSource: remoteMobileFirebaseDataSource,
        remoteWebFirebaseDataSource: remoteWebFirebaseDataSource,
        config: config);
  });

  group("dataStorageLocation", (){
    test("test for DataStorageLocation.LOCAL_MOBILE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      final result = await repository.dataSource;
      expect(result, localMobileDataSource);
    });

    test("test for DataStorageLocation.REMOTE_MOBILE_FIREBASE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.REMOTE_MOBILE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, remoteMobileFirebaseDataSource);
    });

    test("test for DataStorageLocation.REMOTE_WEB_FIREBASE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.REMOTE_WEB_FIREBASE);
      final result = await repository.dataSource;
      expect(result, remoteWebFirebaseDataSource);
    });
  });
}
