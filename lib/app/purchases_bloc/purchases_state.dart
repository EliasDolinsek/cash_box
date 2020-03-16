import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:equatable/equatable.dart';

abstract class PurchasesState extends Equatable {}

class InitialPurchasesState extends PurchasesState {
  @override
  List<Object> get props => [];
}

class SubscriptionsStreamAvailableState extends PurchasesState {

  final Stream<SubscriptionInfo> stream;

  SubscriptionsStreamAvailableState(this.stream);

  @override
  List get props => [stream];

}

class CurrentSubscriptionState extends PurchasesState {

  final SubscriptionInfo subscriptionInfo;

  CurrentSubscriptionState(this.subscriptionInfo);

  @override
  List get props => [subscriptionInfo];

}

class PurchasesErrorState extends PurchasesState {

  final String errorMessage;

  PurchasesErrorState(this.errorMessage);

  @override
  List get props => [errorMessage];
}