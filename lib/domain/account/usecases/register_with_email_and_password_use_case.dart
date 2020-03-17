import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterWithEmailAndPasswordUseCase extends UseCase<EmptyData, RegisterWithEmailAndPasswordUseCaseParams> {

  final FirebaseAuth firebaseAuth;

  RegisterWithEmailAndPasswordUseCase(this.firebaseAuth);

  @override
  Future<Either<Failure, EmptyData>> call(RegisterWithEmailAndPasswordUseCaseParams params) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: params.email, password: params.password);
      return Right(EmptyData());
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