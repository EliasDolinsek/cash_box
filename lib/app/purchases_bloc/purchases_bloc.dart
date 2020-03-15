import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PurchasesBloc extends Bloc<PurchasesEvent, PurchasesState> {
  @override
  PurchasesState get initialState => InitialPurchasesState();

  @override
  Stream<PurchasesState> mapEventToState(
    PurchasesEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
