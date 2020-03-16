import 'package:cash_box/app/purchases_bloc/bloc.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/usecases/get_subscriptions_stream_use_case.dart';
import 'package:cash_box/domain/account/usecases/purchase_subscription_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetSubscriptionsStreamUseCase extends Mock
    implements GetSubscriptionStreamUseCase {}

class MockPurchaseSubscriptionUseCase extends Mock
    implements PurchaseSubscriptionUseCase {}

void main() {
  final MockGetSubscriptionsStreamUseCase getSubscriptionsStreamUserCase =
      MockGetSubscriptionsStreamUseCase();
  final MockPurchaseSubscriptionUseCase purchaseSubscriptionUseCase =
      MockPurchaseSubscriptionUseCase();

  PurchasesBloc bloc;

  setUp(() {
    bloc = PurchasesBloc(
        getSubscriptionStreamUseCase: getSubscriptionsStreamUserCase,
        purchaseSubscriptionUseCase: purchaseSubscriptionUseCase);
  });

  test("GetCurrentSubscriptionEvent", () async {
    final String testUserID = "abc-123";
    final params = GetSubscriptionStreamUseCaseParams(testUserID);
    final subscriptionInfoStream = Stream.value(SubscriptionInfo(
        subscriptionType: SubscriptionType.business_free,
        purchaseDate: DateTime.now()));

    when(getSubscriptionsStreamUserCase.call(params)).thenAnswer(
      (_) async => Right(subscriptionInfoStream),
    );

    final result = [
      InitialPurchasesState(),
      CurrentSubscriptionState(await subscriptionInfoStream.first)
    ];

    //NOT working because stream isn't sending any new data
    expectLater(bloc.state, emitsInOrder(result));

    final event = GetCurrentSubscriptionEvent(testUserID);
    bloc.dispatch(event);
  });

  test("GetSubscriptionsStreamEvent", () async {
    final userID = "abc-123";
    final params = GetSubscriptionStreamUseCaseParams(userID);
    final stream = Stream.value(SubscriptionInfo(
        subscriptionType: SubscriptionType.business_free,
        purchaseDate: DateTime.now()));

    when(getSubscriptionsStreamUserCase(params))
        .thenAnswer((_) async => Right(stream));

    final expected = [
      InitialPurchasesState(),
      SubscriptionsStreamAvailableState(stream)
    ];

    expectLater(bloc.state, emitsInOrder(expected));

    final event = GetSubscriptionsStreamEvent(userID);
    bloc.dispatch(event);
  });

  test("PurchaseSubscriptionEvent", () async {
    final userID = "abc-123";
    final type = SubscriptionType.business_pro;

    final params = PurchaseSubscriptionUseCaseParams(userID, type);
    when(purchaseSubscriptionUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialPurchasesState()];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = PurchaseSubscriptionEvent(userID, type);
    bloc.dispatch(event);
  });
}
