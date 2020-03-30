import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ReceiptMonthBloc extends Bloc<ReceiptMonthEvent, ReceiptMonthState> {

  DateTime _receiptMonth;

  ReceiptMonthBloc(this._receiptMonth);

  @override
  ReceiptMonthState get initialState => ReceiptMonthAvailableState(_receiptMonth);

  @override
  Stream<ReceiptMonthState> mapEventToState(
    ReceiptMonthEvent event,
  ) async* {
    if(event is SetReceiptMonthEvent){
      _receiptMonth = event.receiptMonth;
      yield ReceiptMonthAvailableState(_receiptMonth);
    }
  }
}
