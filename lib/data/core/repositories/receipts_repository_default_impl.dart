import 'package:cash_box/core/errors/exceptions.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_remote_firebase_data_source.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';

class ReceiptsRepositoryDefaultImpl implements ReceiptsRepository {
  final Config config;

  final ReceiptsLocalMobileDataSource receiptsLocalMobileDataSource;
  final ReceiptsRemoteFirebaseDataSource
      receiptsRemoteFirebaseDataSource;

  ReceiptsRepositoryDefaultImpl({
    @required this.config,
    @required this.receiptsLocalMobileDataSource,
    @required this.receiptsRemoteFirebaseDataSource,
  });

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
  Future<ReceiptsDataSource> get dataSource async {
    final dataStorageLocation = await config.dataStorageLocation;
    switch (dataStorageLocation) {
      case DataStorageLocation.LOCAL_MOBILE:
        return receiptsLocalMobileDataSource;
      case DataStorageLocation.REMOTE_FIREBASE:
        return receiptsRemoteFirebaseDataSource;
      default:
        throw DataStorageLocationException();
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
      await dataSource.removeType(id);
      return Right(EmptyData());
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> updateReceipt(
      String id, Receipt receipt) async {
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

  @override
  Future<Either<Failure, List<Receipt>>> getReceiptsInReceiptMonth(ReceiptMonth receiptMonth) async {
    try {
      final dataSource = await this.dataSource;
      final result = await dataSource.getReceiptsInReceiptMonth(receiptMonth);
      return Right(result);
    } on DataStorageLocationException {
      return Left(DataStorageLocationFailure());
    } on Exception {
      return Left(RepositoryFailure());
    }
  }
}
