import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/enteties/tag.dart';
import 'package:dartz/dartz.dart';

abstract class ReceiptsRepository {

  Future<Either<Failure, List<Receipt>>> getReceipts();
  Future<Either<Failure, Receipt>> getReceipt(String id);

  Future<Either<Failure, void>> updateReceipt(String id, Receipt receipt);

  Future<Either<Failure, void>> addReceiptTag(String id, Tag tag);
  Future<Either<Failure, void>> addReceiptField(String id, Tag tag);

}