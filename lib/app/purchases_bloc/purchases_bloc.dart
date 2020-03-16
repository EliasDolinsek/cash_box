import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/domain/account/usecases/get_subscriptions_stream_use_case.dart';
import 'package:cash_box/domain/account/usecases/purchase_subscription_use_case.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class PurchasesBloc extends Bloc<PurchasesEvent, PurchasesState> {

  final PurchaseSubscriptionUseCase purchaseSubscriptionUseCase;
  final GetSubscriptionStreamUseCase getSubscriptionStreamUseCase;

  PurchasesBloc({@required this.purchaseSubscriptionUseCase, @required this.getSubscriptionStreamUseCase});

  @override
  PurchasesState get initialState => InitialPurchasesState();

  @override
  Stream<PurchasesState> mapEventToState(
    PurchasesEvent event,
  ) async* {
    if(event is GetCurrentSubscriptionEvent){
      yield await _getCurrentSubscription(event.userID);
    } else if(event is GetSubscriptionsStreamEvent){
      yield await _getSubscriptionStream(event.userID);
    } else if(event is PurchaseSubscriptionEvent){
      final params = PurchaseSubscriptionUseCaseParams(event.userID, event.type);
      await purchaseSubscriptionUseCase(params);
    }
  }

  Future<PurchasesState> _getSubscriptionStream(String userID) async {
    final params = GetSubscriptionStreamUseCaseParams(userID);
    final streamEither = await getSubscriptionStreamUseCase(params);
    return streamEither.fold((l) => PurchasesErrorState(l.toString()), (stream){
      return SubscriptionsStreamAvailableState(stream);
    });
  }

  Future<PurchasesState> _getCurrentSubscription(String userID) async {
    final params = GetSubscriptionStreamUseCaseParams(userID);
    final streamEither = await getSubscriptionStreamUseCase(params);
    return streamEither.fold((l) => PurchasesErrorState(l.toString()), (stream) async {
      final subscriptionInfo = await stream.first;
      return CurrentSubscriptionState(subscriptionInfo);
    });
  }
}
