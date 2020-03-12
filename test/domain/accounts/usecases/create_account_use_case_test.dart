import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/usecases/create_account_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main() {
  MockAccountsRepository repository;
  CreateAccountUseCase useCase;

  setUp(() {
    repository = MockAccountsRepository();
    useCase = CreateAccountUseCase(repository);
  });

  test("should call the repository to create a new account", () async {
    final testAccount = Account(
        userID: "user-id",
        signInSource: SignInSource.firebase,
        accountType: AccountType.business,
        email: "elias.dolinsek@gmail.com",
        password: "Test",
        name: "Elias Dolinsek");

    when(repository.createAccount(any))
        .thenAnswer((realInvocation) async => Right(EmptyData()));

    final params = CreateAccountUseCaseParams(testAccount);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.createAccount(testAccount));
  });
}
