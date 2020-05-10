import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendResetPasswordEmailUseCase extends UseCase<EmptyData, SendResetPasswordEmailUseCaseParams> {

  final FirebaseAuth firebaseAuth;

  SendResetPasswordEmailUseCase(this.firebaseAuth);

  @override
  Future<Either<Failure, EmptyData>> call(SendResetPasswordEmailUseCaseParams params) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: params.email);
    } on Exception {
      return Left(SendResetPasswordEmailFailure());
    }

    return Right(EmptyData());
  }

}

class SendResetPasswordEmailUseCaseParams extends Equatable {

  final String email;

  SendResetPasswordEmailUseCaseParams(this.email);

  @override
  List get props => [email];
}