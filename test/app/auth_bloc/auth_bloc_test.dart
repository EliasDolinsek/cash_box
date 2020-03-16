import 'package:cash_box/app/auth_bloc/auth_bloc.dart';
import 'package:cash_box/app/auth_bloc/auth_event.dart';
import 'package:cash_box/app/auth_bloc/auth_state.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/sign_in_state.dart';
import 'package:cash_box/domain/account/usecases/get_sign_in_state_use_case.dart';
import 'package:cash_box/domain/account/usecases/send_reset_password_email_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_out_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockSendResetPasswordEmailUseCase extends Mock
    implements SendResetPasswordEmailUseCase {}

class MockSignInWithEmailAndPasswordUseCase extends Mock
    implements SignInWithEmailAndPasswordUseCase {}

class MockGetSignInStatuesUseCase extends Mock
    implements GetSignInStateUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

void main() {
  final MockFirebaseAuth firebaseAuth = MockFirebaseAuth();

  final MockSendResetPasswordEmailUseCase sendResetPasswordEmailUseCase =
      MockSendResetPasswordEmailUseCase();

  final MockSignInWithEmailAndPasswordUseCase
      signInWithEmailAndPasswordUseCase =
      MockSignInWithEmailAndPasswordUseCase();

  final MockGetSignInStatuesUseCase getSignInStateUseCase =
      MockGetSignInStatuesUseCase();

  final MockSignOutUseCase signOutUseCase = MockSignOutUseCase();

  AuthBloc authBloc;

  setUp(() {
    authBloc = AuthBloc(
        sendResetPasswordEmailUseCase: sendResetPasswordEmailUseCase,
        signInWithEmailAndPasswordUseCase: signInWithEmailAndPasswordUseCase,
        getSignInStateUseCase: getSignInStateUseCase,
        signOutUseCase: signOutUseCase);
  });

  test("SendResetPasswordEmailEvent", () async {
    final testEmail = "email@gmail.com";
    final params = SendResetPasswordEmailUseCaseParams(testEmail);

    when(sendResetPasswordEmailUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialAuthState()];
    expectLater(authBloc.state, emitsInOrder(expected));

    final event = SendResetPasswordEmailEvent(testEmail);
    authBloc.dispatch(event);
  });

  test("SignInWithEmailAndPasswordEvent", () async {
    final testEmail = "email@gmail.com";
    final testPassword = "password";
    final params =
        SignInWithEmailAndPasswordUseCaseParams(testEmail, testPassword);

    when(signInWithEmailAndPasswordUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [
      InitialAuthState(),
    ];

    expectLater(authBloc.state, emitsInOrder(expected));

    final event = SendResetPasswordEmailEvent(testEmail);
    authBloc.dispatch(event);
  });

  test("SignOutEvent", () async {
    when(signOutUseCase.call(NoParams()))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialAuthState()];

    expectLater(authBloc.state, emitsInOrder(expected));

    final event = SignOutEvent();
    authBloc.dispatch(event);
  });

  test("LoadAuthEvent", () async {
    final signInState = SignInState.signedInFirebase;
    when(getSignInStateUseCase.call(any))
        .thenAnswer((_) async => Right(signInState));

    final expected = [
      InitialAuthState(),
      SignInStateAvailable(signInState)
    ];

    expectLater(authBloc.state, emitsInOrder(expected));
    authBloc.dispatch(LoadAuthEvent());
  });
}
