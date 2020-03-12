import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/data/core/repositories/repository.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class AccountsRepository implements Repository {

  Future<Either<Failure, EmptyData>> createAccount(Account account);
  Future<Either<Failure, Account>> getAccount(String userID);

  Future<Either<Failure, EmptyData>> updateAccount(String userID, Account account);
  Future<Either<Failure, EmptyData>> deleteAccount(String userID);
  
}