import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/usecases/get_current_subscription_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/account_fixtures.dart';
import 'mocks.dart';

void main(){
  MockSubscriptionsRepository repository;
  GetCurrentSubscriptionUseCase useCase;
  
  setUp((){
    repository = MockSubscriptionsRepository();
    useCase = GetCurrentSubscriptionUseCase(repository);
  });
  
  test("should call the repository to get the first subscription", () async {
    final testUserID = "user-id";
    final subscriptionInfo = accountFixtures.first.subscriptionInfo;
    final stream = Stream<SubscriptionInfo>.value(subscriptionInfo);
    when(repository.getSubscriptionStream(any)).thenAnswer((realInvocation) async => Right(stream));

    final params = GetCurrentSubscriptionUseCaseParams(testUserID);
    final result = await useCase(params);

    expect(result, Right(subscriptionInfo));
    verify(repository.getSubscriptionStream(testUserID));
  });
}