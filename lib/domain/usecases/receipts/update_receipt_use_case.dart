import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

import 'get_receipt_use_case.dart';

class UpdateReceiptUseCase
    extends UseCase<EmptyData, UpdateReceiptUseCaseParams> {

  final ReceiptsRepository repository;

  UpdateReceiptUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(
      UpdateReceiptUseCaseParams params) async {
    final receiptEither = await _getReceipt(params.id);
    return receiptEither.fold((failure) => Left(failure), (receipt) async {
      final updatedReceipt = _getUpdatedReceipt(receipt, params);
      return await repository.updateReceipt(params.id, updatedReceipt);
    });
  }

  Receipt _getUpdatedReceipt(Receipt receipt,
      UpdateReceiptUseCaseParams params) {
    var type, fields, tagIDs;
    if (params.type != null) type = params.type;
    if (params.fields != null) fields = params.fields;
    if (params.tagIDs != null) tagIDs = params.tagIDs;

    return Receipt(params.id, type: type ?? receipt.type,
        fields: fields ?? receipt.fields,
        creationDate: receipt.creationDate,
        tagIDs: tagIDs ?? receipt.tagIDs);
  }

  Future<Either<Failure, Receipt>> _getReceipt(String id) async {
    final params = GetReceiptUseCaseParams(id);
    final getReceiptUseCase = GetReceiptUseCase(repository);
    return await getReceiptUseCase(params);
  }

}

class UpdateReceiptUseCaseParams {

  final String id;
  final ReceiptType type;
  final List<Field> fields;
  final List<String> tagIDs;

  UpdateReceiptUseCaseParams(this.id, {this.type, this.fields, this.tagIDs});
}