import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/account_fixtures.dart';
import 'mocks.dart';

void main() {
  MockAccountsRepository repository;
  UpdateAccountUseCase useCase;

  setUp(() {
    repository = MockAccountsRepository();
    useCase = UpdateAccountUseCase(repository);
  });

  test("should call the repository to get an account", () async {
    final testID = "user-id-01";
    final testUpdateAccount = accountFixtures.first;

    final testEmail = "update";
    final testName = "update";
    final testAppPassword = "update";
    final testSubscriptionInfo = SubscriptionInfo(
        subscriptionType: SubscriptionType.business_pro,
        purchaseDate: DateTime.now());

    when(repository.getAccount(testID)).thenAnswer((realInvocation) async => Right(testUpdateAccount));
    when(repository.updateAccount(any, any))
        .thenAnswer((realInvocation) async => Right(EmptyData()));

    final params = UpdateAccountUseCaseParams(testID,
        email: testEmail,
        name: testName,
        appPassword: testAppPassword,
        subscriptionInfo: testSubscriptionInfo);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));

    final expectedUpdatedAccount = Account(
        userID: testUpdateAccount.userID,
        signInSource: testUpdateAccount.signInSource,
        accountType: testUpdateAccount.accountType,
        email: testEmail,
        appPassword: testAppPassword,
        name: testName,
        subscriptionInfo: testSubscriptionInfo);

    verify(repository.updateAccount(testID, expectedUpdatedAccount));
  });
}
