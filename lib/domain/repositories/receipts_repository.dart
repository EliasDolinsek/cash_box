import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class ReceiptsRepository {

  Future<Either<Failure, List<Receipt>>> getReceipts();
  Future<Either<Failure, EmptyData>> updateReceipt(String id, Receipt receipt);
  Future<Either<Failure, EmptyData>> removeReceipt(String id);

}