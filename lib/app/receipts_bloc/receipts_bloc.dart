import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ReceiptsBloc extends Bloc<ReceiptsEvent, ReceiptsState> {
  @override
  ReceiptsState get initialState => InitialReceiptsState();

  @override
  Stream<ReceiptsState> mapEventToState(
    ReceiptsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
