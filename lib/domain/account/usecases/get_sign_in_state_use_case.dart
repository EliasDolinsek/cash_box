import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/sign_in_state.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetSignInStateUseCase extends UseCase<SignInState, NoParams> {

  final FirebaseAuth firebaseAuth;

  GetSignInStateUseCase(this.firebaseAuth);

  @override
  Future<Either<Failure, SignInState>> call(NoParams params) async {
    try {
      final user = await firebaseAuth.currentUser();
      if(user == null){
        return Right(SignInState.signedOut);
      } else if (user.isAnonymous){
        return Right(SignInState.signedInAnonymously);
      } else {
        return Right(SignInState.signedInFirebase);
      }
    } on Exception {
      return Left(FirebaseFailure());
    }
  }

}