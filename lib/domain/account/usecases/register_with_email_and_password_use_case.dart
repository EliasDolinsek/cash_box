import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/notify_user_id_changed_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterWithEmailAndPasswordUseCase
    extends AsyncUseCase<String, RegisterWithEmailAndPasswordUseCaseParams> {

  final FirebaseAuth firebaseAuth;
  final NotifyUserIdChangedUseCase notifyUserIdChangedUseCase;

  RegisterWithEmailAndPasswordUseCase(this.firebaseAuth, this.notifyUserIdChangedUseCase);

  @override
  Future<Either<Failure, String>> call(
      RegisterWithEmailAndPasswordUseCaseParams params) async {
    try {
      final result = await firebaseAuth
          .createUserWithEmailAndPassword(
              email: params.email, password: params.password);

      final userId = result.user.uid;
      notifyUserIdChangedUseCase.call(NotifyUserIdChangedUseCaseParams(userId));

      return Right(userId);
    } on Exception {
      return Left(FirebaseFailure());
    }
  }
}

class RegisterWithEmailAndPasswordUseCaseParams extends Equatable {
  final String email, password;

  RegisterWithEmailAndPasswordUseCaseParams(this.email, this.password);

  @override
  List get props => [email, password];
}
