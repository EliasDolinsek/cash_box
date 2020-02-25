import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/datasources/buckets/buckets_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/datasources/buckets/buckets_remote_web_firebase_data_source.dart';
import 'package:mockito/mockito.dart';

class MockConfig extends Mock implements Config {}

class MockBucketsLocalMobileDataSource extends Mock implements BucketsLocalMobileDataSource {}

class MockBucketsRemoteMobileFirebaseDataSource extends Mock implements BucketsRemoteMobileFirebaseDataSource {}

class MockBucketsRemoteWebFirebaseDataSource extends Mock implements BucketsRemoteWebFirebaseDataSource {}