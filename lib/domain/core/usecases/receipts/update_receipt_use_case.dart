import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:dartz/dartz.dart';

import '../use_case.dart';
import 'get_receipt_use_case.dart';

class UpdateReceiptUseCase
    extends AsyncUseCase<EmptyData, UpdateReceiptUseCaseParams> {

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
    return Receipt(params.id, type: params.type ?? receipt.type,
        fields: params.fields ?? receipt.fields,
        creationDate: params.creationDate ?? receipt.creationDate,
        tagIDs: params.tagIDs ?? receipt.tagIDs);
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
  final DateTime creationDate;

  UpdateReceiptUseCaseParams(this.id, {this.type, this.fields, this.tagIDs, this.creationDate});
}