import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateUserPasswordUseCase extends UseCase<EmptyData, UpdateUserPasswordUseCaseParams> {

  final FirebaseAuth firebaseAuth;

  UpdateUserPasswordUseCase(this.firebaseAuth);

  @override
  Future<Either<Failure, EmptyData>> call(UpdateUserPasswordUseCaseParams params) async {
    try {
      final user = await firebaseAuth.currentUser();
      await user.updatePassword(params.password);
      return Right(EmptyData());
    } on Exception {
      return Left(FirebaseFailure());
    }
  }

}

class UpdateUserPasswordUseCaseParams extends Equatable {

  final String password;

  UpdateUserPasswordUseCaseParams(this.password);

  @override
  List get props => [password];
}