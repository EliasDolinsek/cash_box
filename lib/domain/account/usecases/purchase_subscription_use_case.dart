import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PurchaseSubscriptionUseCase extends AsyncUseCase<EmptyData, PurchaseSubscriptionUseCaseParams> {

  final AccountsRepository repository;

  PurchaseSubscriptionUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(PurchaseSubscriptionUseCaseParams params) {
    final updatedSubscriptionInfo = SubscriptionInfo(subscriptionType: params.type, purchaseDate: DateTime.now());
    return _updateSubscriptionInfo(params.userID, updatedSubscriptionInfo);
  }

  Future<Either<Failure, EmptyData>> _updateSubscriptionInfo(String userID, SubscriptionInfo update){
    final updateAccountUseCase = UpdateAccountUseCase(repository);
    final updateAccountUseCaseParams = UpdateAccountUseCaseParams(userID, subscriptionInfo: update);
    return updateAccountUseCase(updateAccountUseCaseParams);
  }

}

class PurchaseSubscriptionUseCaseParams extends Equatable {

  final String userID;
  final SubscriptionType type;

  PurchaseSubscriptionUseCaseParams(this.userID, this.type);

  @override
  List get props => [type];
}