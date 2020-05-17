import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserIdUserCase extends AsyncUseCase<String, NoParams> {

  final FirebaseAuth firebaseAuth;

  GetUserIdUserCase(this.firebaseAuth);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    return Right(firebaseUser?.uid);
  }

}