import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  @override
  AccountsState get initialState => InitialAccountsState();

  @override
  Stream<AccountsState> mapEventToState(
    AccountsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
