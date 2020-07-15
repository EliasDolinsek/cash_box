import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignOutUseCase extends AsyncUseCase<EmptyData, NoParams> {

  final FirebaseAuth firebaseAuth;
  final Config config;

  SignOutUseCase(this.firebaseAuth, this.config);

  @override
  Future<Either<Failure, EmptyData>> call(NoParams params) async {
    try {
      await firebaseAuth.signOut();
      config.setDataStorageLocation(null);
      return Right(EmptyData());
    } on Exception {
      return Left(SignOutFailure());
    }
  }

}