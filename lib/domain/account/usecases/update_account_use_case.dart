import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/account/usecases/get_account_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateAccountUseCase
    extends UseCase<EmptyData, UpdateAccountUseCaseParams> {
  final AccountsRepository repository;

  UpdateAccountUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(
      UpdateAccountUseCaseParams params) async {
    final accountEither = await _getAccountFromUserID(params.userID);
    return accountEither.fold((l) => Left(l), (account) {
      Account updatedAccount = _getUpdate(account, params);
      return repository.updateAccount(params.userID, updatedAccount);
    });
  }

  Account _getUpdate(Account original, UpdateAccountUseCaseParams params) {
    return Account(userID: original.userID,
        signInSource: original.signInSource,
        accountType: original.accountType,
        email: params.email ?? original.email,
        appPassword: params.appPassword ?? original.appPassword,
        name: params.name ?? original.name,
        subscriptionInfo: params.subscriptionInfo ?? original.subscriptionInfo);
  }

  Future<Either<Failure, Account>> _getAccountFromUserID(String userID) async {
    final useCase = GetAccountUseCase(repository);
    final params = GetAccountUseCaseParams(userID);
    return useCase(params);
  }
}

class UpdateAccountUseCaseParams extends Equatable {
  final String userID;
  final String email, appPassword, name;
  final SubscriptionInfo subscriptionInfo;

  UpdateAccountUseCaseParams(this.userID,
      {this.email, this.appPassword, this.name, this.subscriptionInfo});

  @override
  List get props => [userID, email, appPassword, name, subscriptionInfo];
}
