import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable(nullable: false)
class SubscriptionInfo extends Equatable {

  final SubscriptionType subscriptionType;
  final DateTime purchaseDate;

  SubscriptionInfo({@required this.subscriptionType, @required this.purchaseDate});

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) => _$SubscriptionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionInfoToJson(this);

  @override
  List get props => [subscriptionType, purchaseDate];
}

enum SubscriptionType { personal_free, business_free, personal_pro, business_pro }