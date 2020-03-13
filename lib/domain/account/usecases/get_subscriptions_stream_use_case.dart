import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/repositories/subscriptions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetSubscriptionStreamUseCase extends UseCase<Stream<SubscriptionInfo>, GetSubscriptionStreamUseCaseParams> {

  final SubscriptionsRepository repository;

  GetSubscriptionStreamUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<SubscriptionInfo>>> call(GetSubscriptionStreamUseCaseParams params) {
    return repository.getSubscriptionStream(params.userID);
  }

}

class GetSubscriptionStreamUseCaseParams extends Equatable {

  final String userID;

  GetSubscriptionStreamUseCaseParams(this.userID);

  @override
  List get props => [userID];
}