import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/repositories/subscriptions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCurrentSubscriptionUseCase extends AsyncUseCase<SubscriptionInfo, GetCurrentSubscriptionUseCaseParams> {

  final SubscriptionsRepository repository;

  GetCurrentSubscriptionUseCase(this.repository);

  @override
  Future<Either<Failure, SubscriptionInfo>> call(GetCurrentSubscriptionUseCaseParams params) async {
    final subscriptionStreamEither = await repository.getSubscriptionStream(params.userID);
    return subscriptionStreamEither.fold((l) => Left(l), (subscriptionStream) async {
      final subscriptionInfo = await subscriptionStream.first;
      return Right(subscriptionInfo);
    });
  }

}

class GetCurrentSubscriptionUseCaseParams extends Equatable {

  final String userID;

  GetCurrentSubscriptionUseCaseParams(this.userID);

  @override
  List get props => [userID];
}