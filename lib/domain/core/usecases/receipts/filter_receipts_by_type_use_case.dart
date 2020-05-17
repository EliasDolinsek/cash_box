import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

class FilterReceiptByTypeUseCase
    extends SecureSyncUseCase<List<Receipt>, FilterReceiptByTypeUseCaseParams> {
  @override
  List<Receipt> call(FilterReceiptByTypeUseCaseParams params) {
    return params.receipts
        .where((element) => element.type == params.receiptType)
        .toList();
  }
}

class FilterReceiptByTypeUseCaseParams extends Equatable {
  final List<Receipt> receipts;
  final ReceiptType receiptType;

  FilterReceiptByTypeUseCaseParams(
      {@required this.receipts, @required this.receiptType});

  @override
  List get props => [receipts];
}
