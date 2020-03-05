import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/datasources/datasource.dart';
import 'package:cash_box/data/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/data/datasources/receipts/receipts_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/datasources/receipts/receipts_remote_web_firebase_data_source.dart';
import 'package:cash_box/data/repositories/repository.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class ReceiptsRepositoryDefaultImpl implements ReceiptsRepository, Repository {

  final Config config;

  final ReceiptsLocalMobileDataSource receiptsLocalMobileDataSource;
  final ReceiptsRemoteMobileFirebaseDataSource
      receiptsRemoteMobileFirebaseDataSource;
  final ReceiptsRemoteWebFirebaseDataSource receiptsRemoteWebFirebaseDataSource;

  ReceiptsRepositoryDefaultImpl(
      {@required this.config,
      @required this.receiptsLocalMobileDataSource,
      @required this.receiptsRemoteMobileFirebaseDataSource,
      @required this.receiptsRemoteWebFirebaseDataSource});

  @override
  Future<Either<Failure, EmptyData>> addReceipt(Receipt receipt) {
    // TODO: implement addReceipt
    throw UnimplementedError();
  }

  @override
  // TODO: implement dataSource
  Future<DataSource> get dataSource async {
    final dataStorageLocation = await config.dataStorageLocation;
    switch(dataStorageLocation){
      case DataStorageLocation.LOCAL_MOBILE: return receiptsLocalMobileDataSource;
      case DataStorageLocation.REMOTE_MOBILE_FIREBASE: return receiptsRemoteMobileFirebaseDataSource;
      case DataStorageLocation.REMOTE_WEB_FIREBASE: return receiptsRemoteWebFirebaseDataSource;
      default: throw new Exception("Couldn't resolve a DataSource for dataStorageLcation $dataStorageLocation");
    }
  }

  @override
  Future<Either<Failure, List<Receipt>>> getReceipts() {
    // TODO: implement getReceipts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> removeReceipt(String id) {
    // TODO: implement removeReceipt
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> updateReceipt(String id, Receipt receipt) {
    // TODO: implement updateReceipt
    throw UnimplementedError();
  }
}
