import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class BucketsBloc extends Bloc<BucketsEvent, BucketsState> {
  @override
  BucketsState get initialState => InitialBucketsState();

  @override
  Stream<BucketsState> mapEventToState(
    BucketsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
