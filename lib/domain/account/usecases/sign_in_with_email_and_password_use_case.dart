import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithEmailAndPasswordUseCase extends UseCase<EmptyData, SignInWithEmailAndPasswordUseCaseParams> {

  final FirebaseAuth firebaseAuth;

  SignInWithEmailAndPasswordUseCase(this.firebaseAuth);

  @override
  Future<Either<Failure, EmptyData>> call(SignInWithEmailAndPasswordUseCaseParams params) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: params.email, password: params.password);
      return Right(EmptyData());
    } catch (e) {
      final failure = SignInFailure(e.message);
      return Left(failure);
    }
  }

}

class SignInWithEmailAndPasswordUseCaseParams extends Equatable {

  final String email, password;

  SignInWithEmailAndPasswordUseCaseParams(this.email, this.password);

  @override
  List get props => [email, password];
}