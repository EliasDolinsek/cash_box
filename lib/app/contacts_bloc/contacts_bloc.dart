import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  @override
  ContactsState get initialState => InitialContactsState();

  @override
  Stream<ContactsState> mapEventToState(
    ContactsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
