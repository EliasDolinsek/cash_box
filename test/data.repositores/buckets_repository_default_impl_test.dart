import 'package:cash_box/data/repositories/buckets_repository_default_impl.dart';
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
}
