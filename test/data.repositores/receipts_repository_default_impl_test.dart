import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/repositories/receipts_repository_default_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mocks.dart';

void main() {
  ReceiptsRepositoryDefaultImpl repository;

  MockConfig config = MockConfig();

  MockReceiptsLocalMobileDataSource receiptsLocalMobileDataSource =
      MockReceiptsLocalMobileDataSource();
  MockReceiptsRemoteMobileFirebaseDataSource
      receiptsRemoteMobileFirebaseDataSource =
      MockReceiptsRemoteMobileFirebaseDataSource();
  MockReceiptsRemoteWebFirebaseDataSource receiptsRemoteWebFirebaseDataSource =
      MockReceiptsRemoteWebFirebaseDataSource();

  setUp(() {
    repository = ReceiptsRepositoryDefaultImpl(
        config: config,
        receiptsLocalMobileDataSource: receiptsLocalMobileDataSource,
        receiptsRemoteMobileFirebaseDataSource:
            receiptsRemoteMobileFirebaseDataSource,
        receiptsRemoteWebFirebaseDataSource:
            receiptsRemoteWebFirebaseDataSource);
  });

  group("dataStorageLocation", (){
    test("dataSource with dataStorageLocation = LOCAL_MOBILE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      final result = await repository.dataSource;
      expect(result, receiptsLocalMobileDataSource);
    });

    test("dataSource with dataStorageLocation = REMOTE_MOBILE_FIREBASE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.REMOTE_MOBILE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, receiptsRemoteMobileFirebaseDataSource);
    });

    test("dataSource with dataStorageLocation = LOCAL_MOBILE", () async {
      when(config.dataStorageLocation).thenAnswer((_) async => DataStorageLocation.REMOTE_WEB_FIREBASE);
      final result = await repository.dataSource;
      expect(result, receiptsRemoteWebFirebaseDataSource);
    });
  });
}
