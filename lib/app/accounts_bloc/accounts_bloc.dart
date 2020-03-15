import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/domain/account/usecases/create_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/delete_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/get_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
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
  AccountsState get initialState => InitialAccountsState();

  @override
  Stream<AccountsState> mapEventToState(
    AccountsEvent event,
  ) async* {
    if (event is CreateAccountEvent) {
      final params = CreateAccountUseCaseParams(event.account);
      await createAccountUseCase(params);
    } else if (event is DeleteAccountEvent) {
      final params = DeleteAccountUseCaseParams(event.userID);
      await deleteAccountUseCase(params);
    } else if (event is GetAccountEvent) {
      yield await _getAccount(event);
    } else if (event is UpdateAccountEvent) {
      final params = UpdateAccountUseCaseParams(event.userID,
          name: event.name,
          subscriptionInfo: event.subscriptionInfo,
          appPassword: event.appPassword,
          email: event.email);

      await updateAccountUseCase(params);
    }
  }

  Future<AccountsState> _getAccount(GetAccountEvent event) async {
    final params = GetAccountUseCaseParams(event.userID);
    final accountEither = await getAccountUseCase(params);
    return accountEither.fold((l) => AccountErrorState(l.toString()),
        (account) => AccountAvailableState(account));
  }
}
