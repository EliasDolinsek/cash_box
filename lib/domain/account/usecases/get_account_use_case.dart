import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAccountUseCase extends AsyncUseCase<Account, GetAccountUseCaseParams> {

  final AccountsRepository repository;

  GetAccountUseCase(this.repository);

  @override
  Future<Either<Failure, Account>> call(GetAccountUseCaseParams params) {
    return repository.getAccount(params.userID);
  }

}

class GetAccountUseCaseParams extends Equatable {

  final String userID;

  GetAccountUseCaseParams(this.userID);

  @override
  List get props => [userID];
}