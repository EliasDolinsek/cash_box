import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/usecases/auth/create_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/auth/default_account_helper.dart';
import 'package:cash_box/domain/core/usecases/notify_user_id_changed_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class RegisterWithEmailAndPasswordUseCase
    extends AsyncUseCase<String, RegisterWithEmailAndPasswordUseCaseParams> {
  final FirebaseAuth firebaseAuth;
  final NotifyUserIdChangedUseCase notifyUserIdChangedUseCase;
  final CreateAccountUseCase createAccountUseCase;

  RegisterWithEmailAndPasswordUseCase(this.firebaseAuth,
      this.notifyUserIdChangedUseCase, this.createAccountUseCase);

  @override
  Future<Either<Failure, String>> call(
      RegisterWithEmailAndPasswordUseCaseParams params) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      final userId = result.user.uid;
      _createAccount(userId, params);
      _notifyUserIdChanged(userId);

      return Right(userId);
    } on Exception {
      return Left(FirebaseFailure());
    }
  }

  void _createAccount(
      String userId, RegisterWithEmailAndPasswordUseCaseParams params) {
    final account = getDefaultAccount(
      userId: userId,
      signInSource: SignInSource.firebase,
      accountType: params.accountType,
    );

    final createAccountParams = CreateAccountUseCaseParams(account);
    createAccountUseCase(createAccountParams);
  }

  void _notifyUserIdChanged(String userId) {
    final params = NotifyUserIdChangedParams(userId);
    notifyUserIdChangedUseCase(params);
  }
}

class RegisterWithEmailAndPasswordUseCaseParams extends Equatable {
  final AccountType accountType;
  final String email, password, name;

  RegisterWithEmailAndPasswordUseCaseParams(
      {@required this.email,
      @required this.password,
      @required this.accountType,
      @required this.name});

  @override
  List get props => [email, password];
}
