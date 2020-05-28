import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/domain/account/usecases/create_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/delete_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/get_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final CreateAccountUseCase createAccountUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final GetAccountUseCase getAccountUseCase;
  final UpdateAccountUseCase updateAccountUseCase;

  AccountsBloc(
      {@required this.createAccountUseCase,
      @required this.deleteAccountUseCase,
      @required this.getAccountUseCase,
      @required this.updateAccountUseCase});

  @override
  AccountsState get initialState => AccountsLoadingState();

  @override
  Stream<AccountsState> mapEventToState(
    AccountsEvent event,
  ) async* {
    if (event is CreateAccountEvent) {
      yield AccountsLoadingState();

      final params = CreateAccountUseCaseParams(event.account);
      await createAccountUseCase(params);

      dispatch(GetAccountEvent());
    } else if (event is DeleteAccountEvent) {
      final params = DeleteAccountUseCaseParams(event.userID);
      await deleteAccountUseCase(params);

      dispatch(GetAccountEvent());
    } else if (event is GetAccountEvent) {
      yield await _getAccount(event);
    } else if(event is UpdateAccountEvent){
      yield AccountsLoadingState();

      final userId = await _getUserId();
      await updateAccountUseCase(event.asParams(userId));

      dispatch(GetAccountEvent());
    }
  }

  Future<AccountsState> _getAccount(GetAccountEvent event) async {
    final userId = await _getUserId();
    if (userId != null) {
      final params = GetAccountUseCaseParams(userId);

      final accountEither = await getAccountUseCase(params);
      return accountEither.fold((l) => AccountAvailableState(null),
          (account) => AccountAvailableState(account));
    } else {
      return AccountAvailableState(null);
    }
  }

  Future<String> _getUserId() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser?.uid;
  }
}
