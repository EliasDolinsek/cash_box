import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/notify_user_id_changed_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'sign_in_helper.dart' as signInHelper;

class SignInWithEmailAndPasswordUseCase extends AsyncUseCase<EmptyData, SignInWithEmailAndPasswordUseCaseParams> {

  final FirebaseAuth firebaseAuth;
  final NotifyUserIdChangedUseCase notifyUserIdChangedUseCase;

  SignInWithEmailAndPasswordUseCase(this.firebaseAuth, this.notifyUserIdChangedUseCase);

  @override
  Future<Either<Failure, EmptyData>> call(SignInWithEmailAndPasswordUseCaseParams params) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(email: params.email, password: params.password);

      final userId = result.user.uid;
      notifyUserIdChangedUseCase.call(NotifyUserIdChangedParams(userId));

      return Right(EmptyData());
    } catch (e) {
      if(e is PlatformException){
        final failure = SignInFailure(signInHelper.fromPlatformException(e));
        return Left(failure);
      } else {
        return Left(SignInFailure(SignInFailureType.other));
      }
    }
  }
}

class SignInWithEmailAndPasswordUseCaseParams extends Equatable {

  final String email, password;

  SignInWithEmailAndPasswordUseCaseParams(this.email, this.password);

  @override
  List get props => [email, password];
}