import 'package:equatable/equatable.dart';

class Subscription extends Equatable {

  final SubscriptionType type;
  final DateTime purchaseDate;
  final Duration subscriptionDuration;

  Subscription(this.type, this.purchaseDate, this.subscriptionDuration);

  bool get isExpired => purchaseDate.add(subscriptionDuration).isAfter(DateTime.now());

}

enum SubscriptionType { free, basic, pro }