import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FilterReceiptsUseCase extends UseCase<List<Receipt>, FilterReceiptsUseCaseParams> {

  final ReceiptsRepository repository;

  FilterReceiptsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Receipt>>> call(FilterReceiptsUseCaseParams params) async {
    if(params.receiptMonth != null){
      final result = await repository.getReceiptsInReceiptMonth(params.receiptMonth);
      return result.fold((l) => Left(l), (receipts){
        final filteredReceipts = _filterReceipts(receipts, params.text, params.tagIds, params.receiptType);
        return Right(filteredReceipts);
      });
    } else {
      final result = await repository.getReceipts();
      return result.fold((l) => Left(l), (receipts){
        final filteredReceipts = _filterReceipts(receipts, params.text, params.tagIds, params.receiptType);
        return Right(filteredReceipts);
      });
    }
  }

  List<Receipt> _filterReceipts(List<Receipt> original, String text, List<String> tagIds, ReceiptType receiptType){
      var filteredReceipts = original;

      if(receiptType != null){
        filteredReceipts = filteredReceipts.where((element) => element.type == receiptType).toList();
      }

      if(tagIds != null && tagIds.isNotEmpty){
        filteredReceipts = filteredReceipts.where((element) => _doTagIdsContainTagIds(element.tagIDs, tagIds)).toList();
      }

      if(text != null && text.trim().isNotEmpty){
        filteredReceipts = filteredReceipts.where((element) => _doFieldValuesContainText(element.fields, text)).toList();
      }

      return filteredReceipts ?? [];
  }

  bool _doFieldValuesContainText(List<Field> fields, String text){
    return fields.firstWhere((element) => element.value.toString().contains(text), orElse: () => null) != null;
  }

  bool _doTagIdsContainTagIds(List<String> original, List<String> searched) {
    for(var item in searched){
      if(!original.contains(item)) return false;
    }

    return true;
  }

}

class FilterReceiptsUseCaseParams extends Equatable {

  final String text;
  final List<String> tagIds;
  final ReceiptMonth receiptMonth;
  final ReceiptType receiptType;

  FilterReceiptsUseCaseParams({this.text = "", this.tagIds = const[], this.receiptMonth, this.receiptType});

  @override
  List get props => [text, tagIds, receiptMonth, receiptType];

}