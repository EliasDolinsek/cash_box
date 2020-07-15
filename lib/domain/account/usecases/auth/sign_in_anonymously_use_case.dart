import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/usecases/auth/create_account_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/notify_user_id_changed_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'default_account_helper.dart';
import 'sign_in_helper.dart' as signInHelper;

class SignInAnonymouslyUseCase
    extends AsyncUseCase<EmptyData, SignInAnonymouslyUseCaseParams> {
  final FirebaseAuth firebaseAuth;
  final NotifyUserIdChangedUseCase notifyUserIdChangedUseCase;
  final CreateAccountUseCase createAccountUseCase;

  SignInAnonymouslyUseCase(this.firebaseAuth, this.notifyUserIdChangedUseCase,
      this.createAccountUseCase);

  @override
  Future<Either<Failure, EmptyData>> call(
      SignInAnonymouslyUseCaseParams params) async {
    try {
      final result = await firebaseAuth.signInAnonymously();
      final userId = result.user.uid;

      _notifyUserIdChanged(userId);
      _createAccount(userId, params.accountType);

      return Right(EmptyData());
    } catch (e) {
      print(e);
      if (e is PlatformException) {
        final failure = SignInFailure(signInHelper.fromPlatformException(e));
        return Left(failure);
      } else {
        return Left(SignInFailure(SignInFailureType.other));
      }
    }
  }

  void _createAccount(String userId, AccountType accountType) {
    final account = getDefaultAccount(
      userId: userId,
      signInSource: SignInSource.firebase,
      accountType: accountType,
    );

    createAccountUseCase.call(CreateAccountUseCaseParams(account));
  }

  void _notifyUserIdChanged(String userId) {
    final params = NotifyUserIdChangedParams(userId);
    notifyUserIdChangedUseCase.call(params);
  }
}

class SignInAnonymouslyUseCaseParams extends Equatable {
  final AccountType accountType;

  SignInAnonymouslyUseCaseParams(this.accountType);

  @override
  List get props => [accountType];
}
