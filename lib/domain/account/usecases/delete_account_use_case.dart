import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteAccountUseCase extends AsyncUseCase<EmptyData, DeleteAccountUseCaseParams> {

  final AccountsRepository repository;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(DeleteAccountUseCaseParams params) {
    return repository.deleteAccount(params.userID);
  }

}

class DeleteAccountUseCaseParams extends Equatable {

  final String userID;

  DeleteAccountUseCaseParams(this.userID);

  @override
  List get props => [userID];
}