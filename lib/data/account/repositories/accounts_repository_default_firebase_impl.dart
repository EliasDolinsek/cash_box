
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class AccountsRepositoryDefaultFirebaseImpl extends AccountsRepository {

  final Firestore firestore;

  AccountsRepositoryDefaultFirebaseImpl(this.firestore);

  CollectionReference get usersCollectionReference =>
      firestore.collection("users");

  @override
  Future<Either<Failure, EmptyData>> createAccount(Account account) async {
    try {
      await usersCollectionReference.document(account.userID).setData(account.toJSON());
      return Right(EmptyData());
    } on Exception {
      return Left(AccountsRepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> deleteAccount(String userID) async {
    try {
      final document = usersCollectionReference.document(userID);
      await document.delete();
      return Right(EmptyData());
    } on Exception {
      return Left(AccountsRepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, Account>> getAccount(String userID) async {
    try {
      final documentSnapshot = await usersCollectionReference.document(userID).get();
      final account = Account.fromJSON(documentSnapshot.data);
      return Right(account);
    } on Exception {
      return Left(AccountsRepositoryFailure());
    }
  }

  @override
  Future<Either<Failure, EmptyData>> updateAccount(
      String userID, Account account) async {
    try {
      final document = usersCollectionReference.document(userID);
      await document.setData(account.toJSON());
      return Right(EmptyData());
    } on Exception {
      return Left(AccountsRepositoryFailure());
    }
  }
}
