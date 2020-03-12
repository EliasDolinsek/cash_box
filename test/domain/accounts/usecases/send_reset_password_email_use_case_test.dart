import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/account/usecases/send_reset_password_email_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main(){

  SendResetPasswordEmailUseCase useCase;
  MockFirebaseAuth firebaseAuth;

  setUp((){
    firebaseAuth = MockFirebaseAuth();
    useCase = SendResetPasswordEmailUseCase(firebaseAuth);
  });

  final testEmail = "elias.dolinsek@gmail.com";

  group("call", (){
    test("should call FirebaseAuth to send a reset-password email", () async {
      when(firebaseAuth.sendPasswordResetEmail(email: anyNamed("email"))).thenAnswer((realInvocation) => null);

      final params = SendResetPasswordEmailUseCaseParams(testEmail);
      final result = await useCase(params);

      expect(result, Right(EmptyData()));
      verify(firebaseAuth.sendPasswordResetEmail(email: testEmail));
    });

    test("should return a SendResetPasswordEmailFailure when FirebaseAuth returns an exception", () async {
      when(firebaseAuth.sendPasswordResetEmail(email: anyNamed("email"))).thenThrow(Exception());

      final params = SendResetPasswordEmailUseCaseParams(testEmail);
      final result = await useCase(params);

      expect(result, Left(SendResetPasswordEmailFailure()));
      verify(firebaseAuth.sendPasswordResetEmail(email: testEmail));
    });
  });
}