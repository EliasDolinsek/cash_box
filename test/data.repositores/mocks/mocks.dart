import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_remote_web_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_remote_web_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_remote_web_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/tags/tags_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/tags/tags_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/tags/tags_remote_web_firebase_datasource.dart';
import 'package:cash_box/data/core/datasources/templates/templates_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/templates/templates_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/templates/templates_remote_web_firebase_data_source.dart';
import 'package:mockito/mockito.dart';

class MockConfig extends Mock implements Config {}

//Buckets
class MockBucketsLocalMobileDataSource extends Mock
    implements BucketsLocalMobileDataSource {}

class MockBucketsRemoteMobileFirebaseDataSource extends Mock
    implements BucketsRemoteMobileFirebaseDataSource {}

class MockBucketsRemoteWebFirebaseDataSource extends Mock
    implements BucketsRemoteWebFirebaseDataSource {}

//Receipts
class MockReceiptsLocalMobileDataSource extends Mock
    implements ReceiptsLocalMobileDataSource {}

class MockReceiptsRemoteMobileFirebaseDataSource extends Mock
    implements ReceiptsRemoteMobileFirebaseDataSource {}

class MockReceiptsRemoteWebFirebaseDataSource extends Mock
    implements ReceiptsRemoteWebFirebaseDataSource {}

//Contacts
class MockContactsLocalMobileDataSource extends Mock
    implements ContactsLocalMobileDataSource {}

class MockContactsRemoteMobileFirebaseDataSource extends Mock
    implements ContactsRemoteMobileFirebaseDataSource {}

class MockContactsRemoteWebFirebaseDataSource extends Mock
    implements ContactsRemoteWebFirebaseDataSource {}

//Templates
class MockTemplatesLocalMobileDataSource extends Mock
    implements TemplatesLocalMobileDataSource {}

class MockTemplatesRemoteMobileFirebaseDataSource extends Mock
    implements TemplatesRemoteMobileFirebaseDataSource {}

class MockTemplatesRemoteWebFirebaseDataSource extends Mock
    implements TemplatesRemoteWebFirebaseDataSource {}

//Tags
class MockTagsLocalMobileDataSource extends Mock
    implements TagsLocalMobileDataSource {}

class MockTagsRemoteMobileFirebaseDataSource extends Mock
    implements TagsRemoteMobileFirebaseDataSource {}

class MockTagsRemoteWebFirebaseDataSource extends Mock
    implements TagsRemoteWebFirebaseDataSource {}
