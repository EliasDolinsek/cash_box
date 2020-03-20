import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/data/account/repositories/accounts_repository_default_firebase_impl.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/implementation/contacts_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/contacts/implementation/contacts_remote_firebase_data_source_default_impl.dart';
import 'package:cash_box/data/core/datasources/fields/fields_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/fields/implementation/fields_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/repositories/contacts_repository_default_impl.dart';
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
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:cash_box/domain/core/usecases/contacts/add_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contacts_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/remove_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/update_contact_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future init() async {
  //
  // Moor database
  //

  sl.registerSingleton<QueryExecutor>(
    FlutterQueryExecutor.inDatabaseFolder(path: "data.sqlit"),
  );

  sl.registerSingleton(MoorAppDatabase(sl()));

  //
  // Config
  //

  sl.registerLazySingleton<Config>(() => ConfigDefaultImpl(sl()));

  //
  // Shared Preferences
  //

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //
  // Firebase
  //

  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<Firestore>(Firestore.instance);

  //
  // Auth, Accounts
  //

  // Auth Usecases

  sl.registerLazySingleton<SendResetPasswordEmailUseCase>(
      () => SendResetPasswordEmailUseCase(sl()));

  sl.registerLazySingleton<SignInWithEmailAndPasswordUseCase>(
      () => SignInWithEmailAndPasswordUseCase(sl()));

  sl.registerLazySingleton<RegisterWithEmailAndPasswordUseCase>(
      () => RegisterWithEmailAndPasswordUseCase(sl()));

  sl.registerLazySingleton<GetSignInStateUseCase>(
      () => GetSignInStateUseCase(sl()));

  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl()));

  sl.registerLazySingleton<UpdateUserPasswordUseCase>(
      () => UpdateUserPasswordUseCase(sl()));

  // Account UseCases

  sl.registerLazySingleton(() => GetUserIdUserCase(sl()));

  sl.registerLazySingleton(() => CreateAccountUseCase(sl()));

  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

  sl.registerLazySingleton(() => GetAccountUseCase(sl()));

  sl.registerLazySingleton(
      () => UpdateAccountUseCase(sl(), firebaseAuth: sl()));

  // Repositories

  sl.registerLazySingleton<AccountsRepository>(
      () => AccountsRepositoryDefaultFirebaseImpl(sl()));

  // Bloc

  sl.registerSingleton<AuthBloc>(
    AuthBloc(getSignInStateUseCase: sl()),
  );

  sl.registerSingleton<AccountsBloc>(
    AccountsBloc(
        createAccountUseCase: sl(),
        deleteAccountUseCase: sl(),
        getAccountUseCase: sl(),
        updateAccountUseCase: sl()),
  );

  //
  // Fields
  //

  sl.registerLazySingleton<FieldsLocalMobileDataSource>(
      () => FieldsLocalMobileDataSourceMoorImpl(sl()));

  //
  // Contacts
  //

  // DataSources
  sl.registerLazySingleton<ContactsLocalMobileDataSource>(
      () => ContactsLocalMobileDataSourceMoorImpl(sl(), sl()));

  final userID = (await sl<FirebaseAuth>().currentUser())?.uid;
  sl.registerLazySingleton<ContactsRemoteFirebaseDataSource>(
      () => ContactsRemoteFirebaseDataSourceDefaultImpl(sl(), userID));

  // Repositories
  sl.registerLazySingleton<ContactsRepository>(
    () => ContactsRepositoryDefaultImpl(
      config: sl(),
      localMobileDataSource: sl(),
      remoteFirebaseDataSource: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => AddContactUseCase(sl()));

  sl.registerLazySingleton(() => GetContactUseCase(sl()));

  sl.registerLazySingleton(() => GetContactsUseCase(sl()));

  sl.registerLazySingleton(() => RemoveContactUseCase(sl()));

  sl.registerLazySingleton(() => UpdateContactUseCase(sl()));

  //BLoCs
  sl.registerLazySingleton(
    () => ContactsBloc(
        addContactUseCase: sl(),
        getContactUseCase: sl(),
        getContactsUseCase: sl(),
        removeContactUseCase: sl(),
        updateContactUseCase: sl()),
  );
}
