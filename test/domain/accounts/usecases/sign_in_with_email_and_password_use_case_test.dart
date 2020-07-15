import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/account/usecases/sign_in/sign_in_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main(){

  SignInWithEmailAndPasswordUseCase useCase;
  MockFirebaseAuth firebaseAuth;

  setUp((){
    firebaseAuth = MockFirebaseAuth();
    useCase = SignInWithEmailAndPasswordUseCase(firebaseAuth);
  });


  group("call", (){
    final testEmail = "email@gmail.com", testPassword = "password";

    test("should call FirebaseAuth to sign in with email and password", () async {
      when(firebaseAuth.signInWithEmailAndPassword(email: testEmail, password: testPassword)).thenAnswer((realInvocation) async => null);

      final params = SignInWithEmailAndPasswordUseCaseParams(testEmail, testPassword);
      final result = await useCase(params);

      expect(result, Right(EmptyData()));
      verify(firebaseAuth.signInWithEmailAndPassword(email: testEmail, password: testPassword));
    });

    test("should return a SignInFailure when FirebaseAuth throws an exception", () async {
      final testFailureMessage = "password rong";
      when(firebaseAuth.signInWithEmailAndPassword(email: testEmail, password: testPassword)).thenThrow(Exception(testFailureMessage));

      final params = SignInWithEmailAndPasswordUseCaseParams(testEmail, testPassword);
      final result = await useCase(params);

      final expectedFailure = SignInFailure(testFailureMessage);
      expect(result, Left(expectedFailure));
      verify(firebaseAuth.signInWithEmailAndPassword(email: testEmail, password: testPassword));
    });
  });

}