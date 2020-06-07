import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/app/search_bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/receipts/add_receipt_use_case.dart';
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
  final SearchBloc searchBloc;

  DateTime receiptMonth = DateTime.now();

  ReceiptsBloc({
    @required this.addReceiptUseCase,
    @required this.getReceiptsUseCase,
    @required this.getReceiptsInReceiptMonthUseCase,
    @required this.updateReceiptUseCase,
    @required this.removeReceiptUseCase,
    @required this.searchBloc,
  });

  @override
  ReceiptsState get initialState => LoadingReceiptsState();

  @override
  Stream<ReceiptsState> mapEventToState(
    ReceiptsEvent event,
  ) async* {
    if (event is AddReceiptEvent) {
      yield LoadingReceiptsState();

      final params = AddReceiptUseCaseParams(event.receipt);
      await addReceiptUseCase(params);

      dispatch(GetReceiptsOfMonthEvent());
      searchBloc.dispatch(ReloadSearchEvent());
    } else if (event is GetReceiptsOfMonthEvent) {
      yield LoadingReceiptsState();
      receiptMonth = event.month ?? receiptMonth;
      yield await _getReceiptsOfReceiptMonth();
    } else if (event is UpdateReceiptEvent) {
      yield LoadingReceiptsState();
      await _updateReceipt(event);

      dispatch(GetReceiptsOfMonthEvent());
      searchBloc.dispatch(ReloadSearchEvent());
    } else if (event is RemoveReceiptEvent) {
      yield LoadingReceiptsState();
      final params = RemoveReceiptUseCaseParams(event.receiptID);

      await removeReceiptUseCase(params);
      dispatch(GetReceiptsOfMonthEvent());
      searchBloc.dispatch(ReloadSearchEvent());
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

  Future<ReceiptsState> _getReceiptsOfReceiptMonth() async {
    final params = GetReceiptsInReceiptMonthUseCaseParams(receiptMonth);
    final receiptEither = await getReceiptsInReceiptMonthUseCase(params);

    print("OK");
    return receiptEither.fold((l) {
      print("FUCK $l");
      return ReceiptsAvailableState(null, null);
    },
        (receipts) => ReceiptsAvailableState(receipts, receiptMonth));
  }
}
