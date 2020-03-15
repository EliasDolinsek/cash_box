import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:equatable/equatable.dart';

abstract class PurchasesState extends Equatable {}

class InitialPurchasesState extends PurchasesState {
  @override
  List<Object> get props => [];
}

class SubscriptionsStreamState extends PurchasesState {

  final Stream<SubscriptionInfo> stream;

  SubscriptionsStreamState(this.stream);

  @override
  List get props => [stream];

}

class CurrentSubscriptionState extends PurchasesState {

  final SubscriptionInfo subscriptionInfo;

  CurrentSubscriptionState(this.subscriptionInfo);

  @override
  List get props => [subscriptionInfo];

}

class SubscriptionErrorState extends PurchasesState {

  final String errorMessage;

  SubscriptionErrorState(this.errorMessage);

  @override
  List get props => [errorMessage];
}