import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/repositories/receipts_repository_default_impl.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/field_fixtures.dart';
import '../fixtures/tag_ids_fixtures.dart';
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

  group("dataStorageLocation", () {
    test("dataSource with dataStorageLocation = LOCAL_MOBILE", () async {
      when(config.dataStorageLocation).thenAnswer((
          _) async => DataStorageLocation.LOCAL_MOBILE);
      final result = await repository.dataSource;
      expect(result, receiptsLocalMobileDataSource);
    });

    test(
        "dataSource with dataStorageLocation = REMOTE_MOBILE_FIREBASE", () async {
      when(config.dataStorageLocation).thenAnswer((
          _) async => DataStorageLocation.REMOTE_MOBILE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, receiptsRemoteMobileFirebaseDataSource);
    });

    test("dataSource with dataStorageLocation = LOCAL_MOBILE", () async {
      when(config.dataStorageLocation).thenAnswer((
          _) async => DataStorageLocation.REMOTE_WEB_FIREBASE);
      final result = await repository.dataSource;
      expect(result, receiptsRemoteWebFirebaseDataSource);
    });
  });

  group("addReceipt", () {

    final testReceipt = Receipt("abc-123", type: ReceiptType.BANK_STATEMENT,
        creationDate: DateTime.now(),
        fields: fieldFixtures,
        tagIDs: ["abc-123", "def-456"]);

    test("addReceipt without an Exception in dataSource", () async {
      when(config.dataStorageLocation).thenAnswer((
          _) async => DataStorageLocation.LOCAL_MOBILE);
      when(receiptsLocalMobileDataSource.addType(any)).thenAnswer((_) async =>
          Right(EmptyData()));

      final result = await repository.addReceipt(testReceipt);
      expect(result, Right(EmptyData()));
      verify(receiptsLocalMobileDataSource.addType(testReceipt));
    });

    test("addReceipt with an Exception in dataSource", () async {
      when(config.dataStorageLocation).thenThrow(DataStorageLocationException());
      when(receiptsLocalMobileDataSource.addType(any)).thenAnswer((_) async =>
          Right(EmptyData()));

      final result = await repository.addReceipt(testReceipt);
      expect(result, Left(DataStorageLocationFailure()));
      verifyZeroInteractions(receiptsLocalMobileDataSource);
    });
  });
}
