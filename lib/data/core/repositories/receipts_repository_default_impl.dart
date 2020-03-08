import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_remote_mobile_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_remote_web_firebase_data_source.dart';
import 'package:cash_box/domain/core/enteties/receipt.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class ReceiptsRepositoryDefaultImpl implements ReceiptsRepository {

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
  Future<Either<Failure, EmptyData>> addReceipt(Receipt receipt) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.addType(receipt);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<DataSource> get dataSource async {
    final dataStorageLocation = await config.dataStorageLocation;
    switch(dataStorageLocation){
      case DataStorageLocation.LOCAL_MOBILE: return receiptsLocalMobileDataSource;
      case DataStorageLocation.REMOTE_MOBILE_FIREBASE: return receiptsRemoteMobileFirebaseDataSource;
      case DataStorageLocation.REMOTE_WEB_FIREBASE: return receiptsRemoteWebFirebaseDataSource;
      default: throw DataStorageLocationException();
    }
  }

  @override
  Future<Either<Failure, List<Receipt>>> getReceipts() async {
    try {
      final dataSource = await this.dataSource;
      final receipts = await dataSource.getTypes();
      return Right(receipts);
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(DataStorageLocationFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> removeReceipt(String id) async {
    try {
      final dataSource = await this.dataSource;
      await  dataSource.removeType(id);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> updateReceipt(String id, Receipt receipt) async {
    try {
      final dataSource = await this.dataSource;
      await dataSource.updateType(id, receipt);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }
}
