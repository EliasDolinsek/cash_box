import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateAccountUseCase extends UseCase<EmptyData, UpdateAccountUseCaseParams> {

  final AccountsRepository repository;

  UpdateAccountUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(UpdateAccountUseCaseParams params) {
    return repository.updateAccount(params.userID, params.account);
  }

}

class UpdateAccountUseCaseParams extends Equatable {

  final String userID;
  final Account account;

  UpdateAccountUseCaseParams(this.userID, this.account);

  @override
  List get props => [userID, account];
}