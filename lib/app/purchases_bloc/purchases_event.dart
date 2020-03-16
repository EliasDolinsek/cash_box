import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:equatable/equatable.dart';

abstract class PurchasesEvent extends Equatable {}

class GetCurrentSubscriptionEvent extends PurchasesEvent {

  final String userID;

  GetCurrentSubscriptionEvent(this.userID);

  @override
  List get props => [userID];

}

class GetSubscriptionsStreamEvent extends PurchasesEvent {

  final String userID;

  GetSubscriptionsStreamEvent(this.userID);

  @override
  List get props => [userID];
}

class PurchaseSubscriptionEvent extends PurchasesEvent {

  final String userID;
  final SubscriptionType type;

  PurchaseSubscriptionEvent(this.userID, this.type);

  @override
  List get props => [userID, type];

}