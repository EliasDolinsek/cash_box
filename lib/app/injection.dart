import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/account/repositories/accounts_repository_default_firebase_impl.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/account/usecases/create_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/delete_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/get_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/get_sign_in_state_use_case.dart';
import 'package:cash_box/domain/account/usecases/get_user_id_use_case.dart';
import 'package:cash_box/domain/account/usecases/register_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/account/usecases/send_reset_password_email_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_out_use_case.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/update_password_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future init() async {
  //
  // Accounts
  //

  /*--Firebase--*/
  // Firebase auth
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // Firestore
  sl.registerSingleton<Firestore>(Firestore.instance);

  /*--Auth--*/

  // SendResetPasswordEmailUseCase
  sl.registerLazySingleton<SendResetPasswordEmailUseCase>(
      () => SendResetPasswordEmailUseCase(sl()));

  // SignInWithEmailAndPasswordUseCase
  sl.registerLazySingleton<SignInWithEmailAndPasswordUseCase>(
      () => SignInWithEmailAndPasswordUseCase(sl()));

  // RegisterWithEmailAndPasswordUseCase
  sl.registerLazySingleton<RegisterWithEmailAndPasswordUseCase>(
      () => RegisterWithEmailAndPasswordUseCase(sl()));

  // GetSignInStateUseCase
  sl.registerLazySingleton<GetSignInStateUseCase>(
      () => GetSignInStateUseCase(sl()));

  // SignOutUseCase
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl()));

  // UpdateUserPasswordUseCase
  sl.registerLazySingleton<UpdateUserPasswordUseCase>(() => UpdateUserPasswordUseCase(sl()));

  // AuthBloc
  sl.registerSingleton<AuthBloc>(AuthBloc(getSignInStateUseCase: sl()));
  /*--Accounts-Bloc--*/

  // Accounts Repository
  sl.registerLazySingleton<AccountsRepository>(() => AccountsRepositoryDefaultFirebaseImpl(sl()));

  // GetUserIdUserCase
  sl.registerLazySingleton(() => GetUserIdUserCase(sl()));

  // CreateAccountUseCase
  sl.registerLazySingleton(() => CreateAccountUseCase(sl()));

  // DeleteAccountUseCase
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

  // GetAccountUseCase
  sl.registerLazySingleton(() => GetAccountUseCase(sl()));

  // UpdateAccountUseCase
  sl.registerLazySingleton(() => UpdateAccountUseCase(sl(), firebaseAuth: sl()));

  // AccountsBloc
  sl.registerSingleton<AccountsBloc>(
    AccountsBloc(
        createAccountUseCase: sl(),
        deleteAccountUseCase: sl(),
        getAccountUseCase: sl(),
        updateAccountUseCase: sl()),
  );

  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Config
  sl.registerLazySingleton<Config>(() => ConfigDefaultImpl(sl()));
}
