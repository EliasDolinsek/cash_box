import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/accounts_event.dart';
import 'package:cash_box/app/accounts_bloc/accounts_state.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/usecases/create_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/delete_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/get_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/account_fixtures.dart';

class MockCreateAccountUseCase extends Mock implements CreateAccountUseCase {}

class MockDeleteAccountUseCase extends Mock implements DeleteAccountUseCase {}

class MockGetAccountUseCase extends Mock implements GetAccountUseCase {}

class MockUpdateAccountUseCase extends Mock implements UpdateAccountUseCase {}

void main() {
  final MockCreateAccountUseCase createAccountUseCase =
      MockCreateAccountUseCase();
  final MockDeleteAccountUseCase deleteAccountUseCase =
      MockDeleteAccountUseCase();
  final MockGetAccountUseCase getAccountUseCase = MockGetAccountUseCase();
  final MockUpdateAccountUseCase updateAccountUseCase =
      MockUpdateAccountUseCase();

  final AccountsBloc bloc = AccountsBloc(
      createAccountUseCase: createAccountUseCase,
      deleteAccountUseCase: deleteAccountUseCase,
      getAccountUseCase: getAccountUseCase,
      updateAccountUseCase: updateAccountUseCase);

  test("CreateAccountEvent", () async {
    final account = accountFixtures.first;
    final event = CreateAccountEvent(account);
    final params = CreateAccountUseCaseParams(account);

    when(createAccountUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialAccountsState()];
    expectLater(bloc.state, emitsInOrder(expected));

    bloc.dispatch(event);
  });

  test("DeleteAccountEvent", () async {
    final account = accountFixtures.first;
    final event = DeleteAccountEvent(account.userID);
    final params = DeleteAccountUseCaseParams(account.userID);

    when(deleteAccountUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialAccountsState()];
    expectLater(bloc.state, emitsInOrder(expected));

    bloc.dispatch(event);
  });

  test("GetAccountEvent", () async {
    final account = accountFixtures.first;
    final event = GetAccountEvent(account.userID);
    final params = GetAccountUseCaseParams(account.userID);

    when(getAccountUseCase.call(params))
        .thenAnswer((_) async => Right(account));

    final expected = [InitialAccountsState(), AccountAvailableState(account)];
    expectLater(bloc.state, emitsInOrder(expected));

    bloc.dispatch(event);
  });

  test("UpdateAccountEvent", () async {
    final account = accountFixtures.first;
    final update = Account(
        userID: account.userID,
        signInSource: account.signInSource,
        accountType: account.accountType,
        email: "update",
        appPassword: "update",
        name: "update",
        subscriptionInfo: accountFixtures[1].subscriptionInfo);

    final event = UpdateAccountEvent(
        userID: account.userID,
        email: update.email,
        appPassword: update.appPassword,
        subscriptionInfo: update.subscriptionInfo,
        name: update.name);

    final params = UpdateAccountUseCaseParams(update.userID,
        name: update.name,
        subscriptionInfo: update.subscriptionInfo,
        appPassword: update.appPassword,
        email: update.email
    );

    when(updateAccountUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialAccountsState()];
    expectLater(bloc.state, emitsInOrder(expected));

    bloc.dispatch(event);
  });
}
