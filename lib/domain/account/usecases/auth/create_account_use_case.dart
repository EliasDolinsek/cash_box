import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateAccountUseCase extends AsyncUseCase<EmptyData, CreateAccountUseCaseParams> {

  final AccountsRepository repository;

  CreateAccountUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(CreateAccountUseCaseParams params) async {
    final result = await repository.createAccount(params.account);
    return result;
  }

}

class CreateAccountUseCaseParams extends Equatable {

  final Account account;

  CreateAccountUseCaseParams(this.account);

  @override
  List get props => [account];
}