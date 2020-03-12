import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/data/core/repositories/repository.dart';
import 'package:cash_box/domain/core/enteties/receipt.dart';
import 'package:dartz/dartz.dart';

import 'empty_data.dart';

abstract class ReceiptsRepository implements Repository{

  Future<Either<Failure, List<Receipt>>> getReceipts();
  Future<Either<Failure, EmptyData>> updateReceipt(String id, Receipt receipt);
  Future<Either<Failure, EmptyData>> removeReceipt(String id);
  Future<Either<Failure, EmptyData>> addReceipt(Receipt receipt);

}