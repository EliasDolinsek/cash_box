import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/repositories/buckets_repository_default_impl.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/buckets_fixtures.dart';
import 'mocks/mocks.dart';

void main() {
  BucketsRepositoryDefaultImpl repository;

  MockConfig config = MockConfig();

  //Buckets-data-sources
  MockBucketsLocalMobileDataSource bucketsLocalMobileDataSource =
      MockBucketsLocalMobileDataSource();
  MockBucketsRemoteFirebaseDataSource
      bucketsRemoteMobileFirebaseDataSource =
      MockBucketsRemoteFirebaseDataSource();

  setUp(() {
    repository = BucketsRepositoryDefaultImpl(
        bucketsLocalMobileDataSource: bucketsLocalMobileDataSource,
        bucketsRemoteFirebaseDataSource:
            bucketsRemoteMobileFirebaseDataSource,
        config: config);
  });

  group("dataStorageLocation", () {
    test("test for DataStorageLocation.LOCAL_MOBILE", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      final result = await repository.dataSource;
      expect(result, bucketsLocalMobileDataSource);
    });

    test("test for DataStorageLocation.REMOTE_MOBILE_FIREBASE", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.REMOTE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, bucketsRemoteMobileFirebaseDataSource);
    });

    test("test for DataStorageLocation.REMOTE_WEB_FIREBASE", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.REMOTE_FIREBASE);
      final result = await repository.dataSource;
      expect(result, bucketsRemoteMobileFirebaseDataSource);
    });
  });

  group("getBuckets", () {
    test(
        "should check whichd dataSource to use by getting the storage location",
        () {
      repository.getBuckets();
      verify(config.dataStorageLocation);
    });

    test("getBuckets without an exception and DataStorageLocation.LOCAL_MOBILE",
        () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(bucketsLocalMobileDataSource.getTypes())
          .thenAnswer((_) async => bucketFixtures);
      final result = await repository.getBuckets();

      expect(result, isA<Right>());
    });

    test("getBuckets with an Exception and DataStorageLocation.LOCAL_MOBILE",
        () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(bucketsLocalMobileDataSource.getTypes())
          .thenThrow(Exception("Some error"));
      final result = await repository.getBuckets();

      expect(result, Left(RepositoryFailure()));
    });

    test(
        "getBuckets with an DataStorageLocationException and DataStorageLocation.LOCAL_MOBILE",
        () async {
      when(config.dataStorageLocation).thenAnswer((_) async => null);
      when(bucketsLocalMobileDataSource.getTypes())
          .thenAnswer((_) async => bucketFixtures);
      final result = await repository.getBuckets();

      expect(result, Left(RepositoryFailure()));
    });
  });

  group("addBucket", () {
    final testBucket = Bucket("abc-123",
        name: "Test", description: "Test", receiptsIDs: ["abc-123", "def-456"]);

    test(
        "should get the data source (with an exception), and return an DataStorageFailure",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());
      final result = await repository.addBucket(testBucket);
      expect(result, Left(DataStorageLocationFailure()));
    });

    test("should call the DataSource to add a bucket", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      final result = await repository.addBucket(testBucket);

      expect(result, Right(EmptyData()));
      verify(bucketsLocalMobileDataSource.addType(testBucket));
    });
  });

  group("removeBucket", () {
    String testID = "abc-123";

    test(
        "should return a DataSourceFailure when dataSource throws an DataStorageLocationException",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());
      final result = await repository.removeBucket(testID);

      expect(result, Left(DataStorageLocationFailure()));
      verify(config.dataStorageLocation);
    });

    test("should call the DataSource to remote a bucket", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(bucketsLocalMobileDataSource.removeType(any))
          .thenAnswer((_) async => Right(EmptyData()));

      final result = await repository.removeBucket(testID);
      expect(result, Right(EmptyData()));
      verify(bucketsLocalMobileDataSource.removeType(testID));
    });
  });

  group("updateBucket", () {
    String testID = "abc-123";
    Bucket testBucket = Bucket(testID,
        name: "update", description: "update", receiptsIDs: ["123"]);

    test(
        "should return a DataSourceFailure when dataSource throws an DataStorageLocationException",
        () async {
      when(config.dataStorageLocation)
          .thenThrow(DataStorageLocationException());
      final result = await repository.updateBucket(testID, testBucket);

      expect(result, Left(DataStorageLocationFailure()));
      verify(config.dataStorageLocation);
    });

    test("should call the dataSource to update the bucket", () async {
      when(config.dataStorageLocation)
          .thenAnswer((_) async => DataStorageLocation.LOCAL_MOBILE);
      when(bucketsLocalMobileDataSource.updateType(any, any))
          .thenAnswer((_) async => EmptyData());

      final result = await repository.updateBucket(testID, testBucket);
      expect(result, Right(EmptyData()));
      verify(bucketsLocalMobileDataSource.updateType(testID, testBucket));
    });
  });

}
