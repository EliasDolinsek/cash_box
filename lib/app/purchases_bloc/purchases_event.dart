import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:equatable/equatable.dart';

abstract class PurchasesEvent extends Equatable {}

class GetCurrentSubscriptionEvent extends PurchasesEvent {}

class GetSubscriptionsStreamEvent extends PurchasesEvent {}

class PurchaseSubscriptionEvent extends PurchasesEvent {

  final String userID;
  final SubscriptionType type;

  PurchaseSubscriptionEvent(this.userID, this.type);

  @override
  List get props => [userID, type];

}