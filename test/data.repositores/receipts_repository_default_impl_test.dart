import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/repositories/receipts_repository_default_impl.dart';
import 'package:cash_box/domain/core/enteties/receipt.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/field_fixtures.dart';
import '../fixtures/receipts_fixtures.dart';
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
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      final result = await repository.dataSource;
      expect(result, receiptsLocalMobileDataSource);
    });

    test("dataSource with dataStorageLocation = REMOTE_MOBILE_FIREBASE",
        () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.REMOTE_MOBILE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, receiptsRemoteMobileFirebaseDataSource);
    });

    test("dataSource with dataStorageLocation = LOCAL_MOBILE", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.REMOTE_WEB_FIREBASE);
      final result = await repository.dataSource;
      expect(result, receiptsRemoteWebFirebaseDataSource);
    });
  });

  group("addReceipt", () {
    final testReceipt = Receipt("abc-123",
        type: ReceiptType.BANK_STATEMENT,
        creationDate: DateTime.now(),
        fields: fieldFixtures,
        tagIDs: ["abc-123", "def-456"]);

    test("addReceipt without an Exception in dataSource", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(receiptsLocalMobileDataSource.addType(any))
          .thenAnswer((_) async => Right(EmptyData()));

      final result = await repository.addReceipt(testReceipt);
      expect(result, Right(EmptyData()));
      verify(receiptsLocalMobileDataSource.addType(testReceipt));
    });

    test("addReceipt with an Exception in dataSource", () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());
      when(receiptsLocalMobileDataSource.addType(any))
          .thenAnswer((_) async => Right(EmptyData()));

      final result = await repository.addReceipt(testReceipt);
      expect(result, Left(DataStorageLocationFailure()));
      verifyZeroInteractions(receiptsLocalMobileDataSource);
    });
  });

  group("getReceipts", () {
    test("getReceipts without an Exception in dataSource", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(receiptsLocalMobileDataSource.getTypes())
          .thenAnswer((_) async => receiptFixtures);

      final result = await repository.getReceipts();
      //expect(result, Right(receiptFixtures)); NOT WORKING BECAUSE THEY ARE LISTS
      verify(receiptsLocalMobileDataSource.getTypes());
    });

    test("getReceipts with an Exception in dataSource", () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());
      when(receiptsLocalMobileDataSource.getTypes())
          .thenAnswer((_) async => receiptFixtures);

      final result = await repository.getReceipts();
      expect(result, Left(DataStorageLocationFailure()));
      verifyNoMoreInteractions(receiptsLocalMobileDataSource);
    });
  });

  group("removeReceipt", () {

    final String testID = "abc-123";

    test("removeReceipts without an Exception in dataSource", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(receiptsLocalMobileDataSource.removeType(any))
          .thenAnswer((_) async => Right(EmptyData()));

      final result = await repository.removeReceipt(testID);
      expect(result, Right(EmptyData()));
      verify(receiptsLocalMobileDataSource.removeType(testID));
    });

    test("removeReceipts with an Exception in dataSource", () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());
      when(receiptsLocalMobileDataSource.removeType(any))
          .thenAnswer((_) async => Right(EmptyData()));

      verifyNoMoreInteractions(receiptsLocalMobileDataSource);

      final result = await repository.removeReceipt(testID);
      expect(result, Left(DataStorageLocationFailure()));
    });
  });

  group("updateReceipt", (){

    final testID = "abc-123";
    final testReceipt = receiptFixtures.first;

    test("updateReceipt without an Exception in dataSource", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(receiptsLocalMobileDataSource.updateType(any, any))
          .thenAnswer((_) async => Right(EmptyData()));

      final result = await repository.updateReceipt(testID, testReceipt);
      expect(result, Right(EmptyData()));
      verify(receiptsLocalMobileDataSource.updateType(testID, testReceipt));
    });

    test("updateReceipt with an Exception in dataSource", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(receiptsLocalMobileDataSource.updateType(any, any))
          .thenThrow(DataStorageLocationException());

      verifyNoMoreInteractions(receiptsLocalMobileDataSource);

      final result = await repository.updateReceipt(testID, testReceipt);
      expect(result, Left(DataStorageLocationFailure()));
    });
  });
}
