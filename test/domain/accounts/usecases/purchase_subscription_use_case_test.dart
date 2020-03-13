import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/usecases/purchase_subscription_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/account_fixtures.dart';
import 'mocks.dart';

void main() {
  PurchaseSubscriptionUseCase useCase;
  MockAccountsRepository repository;

  setUp(() {
    repository = MockAccountsRepository();
    useCase = PurchaseSubscriptionUseCase(repository);
  });

  test("should call the repository to update the subscription type", () async {
    final testUserID = "abc-123";
    final testSubscriptionType = SubscriptionType.business_pro;
    when(repository.getAccount(any))
        .thenAnswer((realInvocation) async => Right(accountFixtures.first));
    when(repository.updateAccount(any, any))
        .thenAnswer((realInvocation) async => Right(EmptyData()));

    final params =
        PurchaseSubscriptionUseCaseParams(testUserID, testSubscriptionType);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.updateAccount(testUserID, any));
  });
}
