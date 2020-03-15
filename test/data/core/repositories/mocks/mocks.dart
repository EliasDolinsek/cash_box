import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/tags/tags_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/tags/tags_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/templates/templates_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/templates/templates_remote_firebase_data_source.dart';
import 'package:mockito/mockito.dart';

class MockConfig extends Mock implements Config {}

//Buckets
class MockBucketsLocalMobileDataSource extends Mock
    implements BucketsLocalMobileDataSource {}

class MockBucketsRemoteFirebaseDataSource extends Mock
    implements BucketsRemoteFirebaseDataSource {}

//Receipts
class MockReceiptsLocalMobileDataSource extends Mock
    implements ReceiptsLocalMobileDataSource {}

class MockReceiptsRemoteFirebaseDataSource extends Mock
    implements ReceiptsRemoteFirebaseDataSource {}

//Contacts
class MockContactsLocalMobileDataSource extends Mock
    implements ContactsLocalMobileDataSource {}

class MockContactsRemoteFirebaseDataSource extends Mock
    implements ContactsRemoteFirebaseDataSource {}

//Templates
class MockTemplatesLocalMobileDataSource extends Mock
    implements TemplatesLocalMobileDataSource {}

class MockTemplatesRemoteFirebaseDataSource extends Mock
    implements TemplatesRemoteFirebaseDataSource {}

//Tags
class MockTagsLocalMobileDataSource extends Mock
    implements TagsLocalMobileDataSource {}

class MockTagsRemoteFirebaseDataSource extends Mock
    implements TagsRemoteFirebaseDataSource {}