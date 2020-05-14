import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/app/receipt_month_bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/domain/core/usecases/receipts/add_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipts_in_receipt_month_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipts_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/remove_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/update_receipt_use_case.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class ReceiptsBloc extends Bloc<ReceiptsEvent, ReceiptsState> {
  final AddReceiptUseCase addReceiptUseCase;
  final GetReceiptsUseCase getReceiptsUseCase;
  final GetReceiptsInReceiptMonthUseCase getReceiptsInReceiptMonthUseCase;
  final UpdateReceiptUseCase updateReceiptUseCase;
  final RemoveReceiptUseCase removeReceiptUseCase;
  final ReceiptMonthBloc receiptMonthBloc;

  ReceiptsBloc(
      {@required this.addReceiptUseCase,
      @required this.getReceiptsUseCase,
      @required this.getReceiptsInReceiptMonthUseCase,
      @required this.updateReceiptUseCase,
      @required this.removeReceiptUseCase,
      @required this.receiptMonthBloc});

  @override
  ReceiptsState get initialState => InitialReceiptsState();

  @override
  Stream<ReceiptsState> mapEventToState(
    ReceiptsEvent event,
  ) async* {
    if (event is AddReceiptEvent) {
      final params = AddReceiptUseCaseParams(event.receipt);
      await addReceiptUseCase(params);
      dispatch(GetReceiptsEvent());
    } else if (event is GetReceiptsEvent) {
      yield await _getReceipts();
    } else if (event is GetReceiptsInReceiptMonthEvent) {
      _setReceiptMonth(event.receiptMonth);
      yield await _getReceiptsInReceiptMonth(event);
    } else if (event is UpdateReceiptEvent) {
      await _updateReceipt(event);
      dispatch(GetReceiptsEvent());
    } else if (event is RemoveReceiptEvent) {
      final params = RemoveReceiptUseCaseParams(event.receiptID);
      await removeReceiptUseCase(params);
      dispatch(GetReceiptsEvent());
    }
  }

  Future _updateReceipt(UpdateReceiptEvent event) async {
    final params = UpdateReceiptUseCaseParams(
      event.id,
      type: event.type,
      fields: event.fields,
      tagIDs: event.tagIDs,
      creationDate: event.creationDate,
    );

    await updateReceiptUseCase(params);
  }

  Future<ReceiptsState> _getReceipts() async {
    final receiptEither = await getReceiptsUseCase(NoParams());
    return receiptEither.fold((l) => ReceiptsErrorState(l.toString()),
        (receipts) => ReceiptsAvailableState(receipts));
  }

  Future<ReceiptsState> _getReceiptsInReceiptMonth(
      GetReceiptsInReceiptMonthEvent event) async {
    final params = GetReceiptsInReceiptMonthUseCaseParams(event.receiptMonth);
    final receiptsEither = await getReceiptsInReceiptMonthUseCase(params);
    return receiptsEither.fold((l) => ReceiptsErrorState(l.toString()),
        (receipts) {
      return ReceiptsInReceiptMonthAvailableState(event.receiptMonth, receipts);
    });
  }

  void _setReceiptMonth(ReceiptMonth month) {
    final event = SetReceiptMonthEvent(month.month);
    receiptMonthBloc.dispatch(event);
  }
}
