import 'package:cash_box/domain/account/usecases/get_sign_in_state_use_case.dart';
import 'package:cash_box/domain/account/usecases/send_reset_password_email_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_out_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'auth_bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future init() async {
  //
  // Accounts
  //

  /*--Auth--*/
  //Firebase auth
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // SendResetPasswordEmailUseCase
  sl.registerLazySingleton<SendResetPasswordEmailUseCase>(
      () => SendResetPasswordEmailUseCase(sl()));

  // SignInWithEmailAndPasswordUseCase
  sl.registerLazySingleton<SignInWithEmailAndPasswordUseCase>(
      () => SignInWithEmailAndPasswordUseCase(sl()));

  // GetSignInStateUseCase
  sl.registerLazySingleton<GetSignInStateUseCase>(
      () => GetSignInStateUseCase(sl()));

  // SignOutUseCase
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl()));

  sl.registerSingleton<AuthBloc>(AuthBloc(getSignInStateUseCase: sl()));
}
