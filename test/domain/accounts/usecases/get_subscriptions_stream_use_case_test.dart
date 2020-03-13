import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/usecases/get_subscriptions_stream_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main(){
  MockSubscriptionsRepository repository;
  GetSubscriptionStreamUseCase useCase;

  setUp((){
    repository = MockSubscriptionsRepository();
    useCase = GetSubscriptionStreamUseCase(repository);
  });

  test("should call the repository to get a subscriptions-stream", () async {
    final testUserID = "abc-123";
    final testStream = Stream<SubscriptionInfo>.empty();
    when(repository.getSubscriptionStream(any)).thenAnswer((realInvocation) async => Right(testStream));

    final params = GetSubscriptionStreamUseCaseParams(testUserID);
    final result = await useCase(params);

    expect(result, Right(testStream));
    verify(repository.getSubscriptionStream(testUserID));
  });
}