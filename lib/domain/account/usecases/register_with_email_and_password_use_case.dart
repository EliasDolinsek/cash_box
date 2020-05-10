import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterWithEmailAndPasswordUseCase
    extends UseCase<String, RegisterWithEmailAndPasswordUseCaseParams> {
  final FirebaseAuth firebaseAuth;

  RegisterWithEmailAndPasswordUseCase(this.firebaseAuth);

  @override
  Future<Either<Failure, String>> call(
      RegisterWithEmailAndPasswordUseCaseParams params) async {
    try {
      final result = await firebaseAuth
          .createUserWithEmailAndPassword(
              email: params.email, password: params.password);
      return Right(result.user.uid);
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
