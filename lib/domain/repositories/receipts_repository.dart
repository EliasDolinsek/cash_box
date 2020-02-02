import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/enteties/tag.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class ReceiptsRepository {

  Future<Either<Failure, List<Receipt>>> getReceipts();
  Future<Either<Failure, Receipt>> getReceipt(String id);

  Future<Either<Failure, EmptyData>> updateReceipt(String id, Receipt receipt);

  Future<Either<Failure, EmptyData>> addReceiptTag(String id, Tag tag);
  Future<Either<Failure, EmptyData>> addReceiptField(String id, Tag tag);

}