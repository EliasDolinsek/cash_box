import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/usecases/auth/sign_out_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'send_reset_password_email_use_case_test.dart';

void main(){

  SignOutUseCase useCase;
  MockFirebaseAuth firebaseAuth;

  setUp((){
    firebaseAuth = MockFirebaseAuth();
    useCase = SignOutUseCase(firebaseAuth);
  });

  group("call", (){
    test("should call FirebaseAuth to sign out", () async {
      when(firebaseAuth.signOut()).thenAnswer((realInvocation) => null);

      final result = await useCase(NoParams());
      expect(result, Right(EmptyData()));
      verify(firebaseAuth.signOut());
    });

    test("should return a SignOutFailure when FirebaseAuth throws an Exception", () async {
      when(firebaseAuth.signOut()).thenThrow(Exception());

      final result = await useCase(NoParams());
      expect(result, Left(SignOutFailure()));
      verify(firebaseAuth.signOut());
    });
  });
}