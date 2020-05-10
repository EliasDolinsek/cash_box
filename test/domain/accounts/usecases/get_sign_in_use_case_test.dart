import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/sign_in_state.dart';
import 'package:cash_box/domain/account/usecases/get_sign_in_state_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseUser extends Mock implements FirebaseUser {}

void main(){

  MockFirebaseUser firebaseUser;
  MockFirebaseAuth firebaseAuth;
  GetSignInStateUseCase useCase;

  setUp((){
    firebaseUser = MockFirebaseUser();
    firebaseAuth = MockFirebaseAuth();
    useCase = GetSignInStateUseCase(firebaseAuth);
  });

  test("should return SignInState.signedOut", () async {
    when(firebaseAuth.currentUser()).thenAnswer((_) async => null);

    final result = await useCase(NoParams());
    expect(result, Right(SignInState.signedOut));
  });

  test("should return SignInState.signedInAnonymously", () async {
    when(firebaseAuth.currentUser()).thenAnswer((_) async => firebaseUser);
    when(firebaseUser.isAnonymous).thenReturn(true);

    final result = await useCase(NoParams());
    expect(result, Right(SignInState.signedInAnonymously));
  });

  test("should return SignInState.signedInFirebase", () async {
    when(firebaseAuth.currentUser()).thenAnswer((_) async => firebaseUser);
    when(firebaseUser.isAnonymous).thenReturn(false);

    final result = await useCase(NoParams());
    expect(result, Right(SignInState.signedInFirebase));
  });

  test("should return a FirebaseFailure", () async {
    when(firebaseAuth.currentUser()).thenThrow(Exception("error"));

    final result = await useCase(NoParams());
    expect(result, Left(FirebaseFailure()));
  });
}