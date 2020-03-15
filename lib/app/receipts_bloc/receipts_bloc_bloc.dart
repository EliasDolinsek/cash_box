import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ReceiptsBlocBloc extends Bloc<ReceiptsBlocEvent, ReceiptsBlocState> {
  @override
  ReceiptsBlocState get initialState => InitialReceiptsBlocState();

  @override
  Stream<ReceiptsBlocState> mapEventToState(
    ReceiptsBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
