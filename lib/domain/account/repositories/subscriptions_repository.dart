import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:dartz/dartz.dart';

abstract class SubscriptionsRepository {

  Future<Either<Failure, SubscriptionInfo>> getCurrentSubscription();
  Future<Either<Failure, Stream<SubscriptionInfo>>> getSubscriptionStream();

}