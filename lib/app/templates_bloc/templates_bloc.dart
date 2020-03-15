import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TemplatesBloc extends Bloc<TemplatesEvent, TemplatesState> {
  @override
  TemplatesState get initialState => InitialTemplatesState();

  @override
  Stream<TemplatesState> mapEventToState(
    TemplatesEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
