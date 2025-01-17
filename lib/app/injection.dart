import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/app/search_bloc/bloc.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/domain/account/usecases/auth/sign_in_anonymously_use_case.dart';
import 'package:cash_box/domain/account/usecases/auth/sign_in_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/core/usecases/add_default_components_use_case.dart';
import 'package:cash_box/domain/core/usecases/currency/format_currency_use_case.dart';
import 'package:cash_box/domain/core/usecases/notify_user_id_changed_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/filter_receipts_by_type_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_incomes_outcomes_use_case.dart';
import 'package:cash_box/data/account/repositories/accounts_repository_default_firebase_impl.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/buckets/buckets_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/buckets/implementation/buckets_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/buckets/implementation/buckets_remote_firebase_data_source_default_impl.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/contacts_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/contacts/implementation/contacts_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/contacts/implementation/contacts_remote_firebase_data_source_default_impl.dart';
import 'package:cash_box/data/core/datasources/fields/fields_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/fields/implementation/fields_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/receipts/implementation/receipts_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/receipts/implementation/receipts_remote_firebase_data_source_default_impl.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/tags/implementation/tags_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/tags/implementation/tags_remote_firebase_data_source_default_impl.dart';
import 'package:cash_box/data/core/datasources/tags/tags_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/tags/tags_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/templates/implementation/templates_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/templates/implementation/templates_remote_firebase_data_source_default_impl.dart';
import 'package:cash_box/data/core/datasources/templates/templates_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/templates/templates_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/repositories/buckets_repository_default_impl.dart';
import 'package:cash_box/data/core/repositories/contacts_repository_default_impl.dart';
import 'package:cash_box/data/core/repositories/receipts_repository_default_impl.dart';
import 'package:cash_box/data/core/repositories/tags_repository_default_impl.dart';
import 'package:cash_box/data/core/repositories/templates_repository_default_impl.dart';
import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/account/usecases/auth/create_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/auth/delete_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/get_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/get_sign_in_state_use_case.dart';
import 'package:cash_box/domain/account/usecases/auth/register_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/account/usecases/send_reset_password_email_use_case.dart';
import 'package:cash_box/domain/account/usecases/auth/sign_out_use_case.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
import 'package:cash_box/domain/account/usecases/update_password_use_case.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:cash_box/domain/core/repositories/tags_repository.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_receipt_to_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/get_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/get_buckets_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/remove_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/remove_receipt_from_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/update_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/add_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contacts_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/remove_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/update_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/add_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/filter_receipts_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_amount_of_receipts_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipts_in_receipt_month_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipts_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_total_amount_of_receipts_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/remove_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/update_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/add_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/get_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/get_tags_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/remove_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/update_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/add_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/get_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/get_templates_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/remove_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/update_template_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future start() async {
  await init();
  await setup();
}

Future setup() async {
  sl<AccountsBloc>().dispatch(GetAccountEvent());
  sl<ReceiptsBloc>().dispatch(GetReceiptsOfMonthEvent());
  sl<BucketsBloc>().dispatch(GetBucketsEvent());
  sl<TemplatesBloc>().dispatch(GetTemplatesEvent());
  sl<TagsBloc>().dispatch(GetTagsEvent());
  sl<ContactsBloc>().dispatch(GetContactsEvent());
  sl<SearchBloc>().dispatch(ReceiptsSearchEvent(DateTime.now()));
}

Future init() async {
  _initFirebase();
  final userId = (await sl<FirebaseAuth>().currentUser())?.uid;

  _initMoorDatabase();

  await _initSharedPreferences();

  _initConfig();

  _initFields();

  _initContacts(userId);

  _initReceipts(userId);

  _initTags(userId);

  _initTemplates(userId);

  _initBuckets(userId);

  _initSearch();

  _initCurrency();

  _initNotifyRepositoriesUserIdChangedUseCase();

  _initAddDefaultComponentsUseCase();

  _initAuthAndAccounts();
}

void _initAddDefaultComponentsUseCase() {
  sl.registerLazySingleton(() => AddDefaultComponentsUseCase(sl(), sl(), sl()));
}

void _initNotifyRepositoriesUserIdChangedUseCase() {
  sl.registerLazySingleton(
    () => NotifyUserIdChangedUseCase(sl(), sl(), sl(), sl(), sl()),
  );
}

void _initCurrency() {
  sl.registerLazySingleton(() => FormatCurrencyUseCase());
}

void _initSearch() {
  // UseCases
  sl.registerLazySingleton(() => FilterReceiptsUseCase(sl()));

  // BLoC
  sl.registerLazySingleton(() => SearchBloc(filterReceiptsUseCase: sl()));
}

void _initBuckets(String userId) {
  // DataSources
  sl.registerLazySingleton<BucketsLocalMobileDataSource>(
      () => BucketsLocalMobileDataSourceMoorImpl(sl()));

  sl.registerLazySingleton<BucketsRemoteFirebaseDataSource>(
      () => BucketsRemoteFirebaseDataSourceDefaultImpl(sl(), userId));

  // Repositories
  sl.registerLazySingleton<BucketsRepository>(
    () => BucketsRepositoryDefaultImpl(
      bucketsLocalMobileDataSource: sl(),
      bucketsRemoteFirebaseDataSource: sl(),
      config: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => AddBucketUseCase(sl()));
  sl.registerLazySingleton(() => AddReceiptToBucketUseCase(sl()));
  sl.registerLazySingleton(() => GetBucketUseCase(sl()));
  sl.registerLazySingleton(() => GetBucketsUseCase(sl()));
  sl.registerLazySingleton(() => RemoveBucketUseCase(sl()));
  sl.registerLazySingleton(() => RemoveReceiptFromBucketUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBucketUseCase(sl()));

  // BLoC
  sl.registerLazySingleton(
    () => BucketsBloc(
        addBucketUseCase: sl(),
        addReceiptToBucketUseCase: sl(),
        getBucketsUseCase: sl(),
        removeBucketUseCase: sl(),
        removeReceiptFromBucketUseCase: sl(),
        updateBucketUseCase: sl()),
  );
}

void _initTemplates(String userId) {
  // DataSources
  sl.registerLazySingleton<TemplatesLocalMobileDataSource>(
      () => TemplatesLocalMobileDataSourceMoorImpl(sl(), sl()));

  sl.registerLazySingleton<TemplatesRemoteFirebaseDataSource>(
      () => TemplatesRemoteFirebaseDataSourceDefaultImpl(sl(), userId));

  // Repositories
  sl.registerLazySingleton<TemplatesRepository>(
    () => TemplatesRepositoryDefaultImpl(
        config: sl(),
        localMobileDataSource: sl(),
        remoteMobileFirebaseDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => AddTemplateUseCase(sl()));
  sl.registerLazySingleton(() => GetTemplateUseCase(sl()));
  sl.registerLazySingleton(() => GetTemplatesUseCase(sl()));
  sl.registerLazySingleton(() => RemoveTemplateUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTemplateUseCase(sl()));

  // BLoC
  sl.registerLazySingleton(
    () => TemplatesBloc(
        addTemplateUseCase: sl(),
        getTemplateUseCase: sl(),
        getTemplatesUseCase: sl(),
        removeTemplateUseCase: sl(),
        updateTemplateUseCase: sl()),
  );
}

void _initTags(String userId) {
  // DataSources
  sl.registerLazySingleton<TagsLocalMobileDataSource>(
      () => TagsLocalMobileDataSourceMoorImpl(sl()));
  sl.registerLazySingleton<TagsRemoteFirebaseDataSource>(
      () => TagsRemoteFirebaseDataSourceDefaultImpl(sl(), userId));

  // Repository
  sl.registerLazySingleton<TagsRepository>(
    () => TagsRepositoryDefaultImpl(
        config: sl(),
        localMobileDataSource: sl(),
        remoteFirebaseDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => AddTagUseCase(sl()));
  sl.registerLazySingleton(() => GetTagUseCase(sl()));
  sl.registerLazySingleton(() => GetTagsUseCase(sl()));
  sl.registerLazySingleton(() => RemoveTagUseCase(sl(), sl()));
  sl.registerLazySingleton(() => UpdateTagUseCase(sl()));

  // BLoCs
  sl.registerLazySingleton(
    () => TagsBloc(
        addTagUseCase: sl(),
        getTagUseCase: sl(),
        getTagsUseCase: sl(),
        removeTagUseCase: sl(),
        updateTagUseCase: sl()),
  );
}

void _initReceipts(String userId) {
  // DataSources
  sl.registerLazySingleton<ReceiptsLocalMobileDataSource>(
      () => ReceiptsLocalMobileDataSourceMoorImpl(sl(), sl()));

  sl.registerLazySingleton<ReceiptsRemoteFirebaseDataSource>(
      () => ReceiptsRemoteFirebaseDataSourceDefaultImpl(sl(), userId));

  // Repositories
  sl.registerLazySingleton<ReceiptsRepository>(() =>
      ReceiptsRepositoryDefaultImpl(
          config: sl(),
          receiptsLocalMobileDataSource: sl(),
          receiptsRemoteFirebaseDataSource: sl()));

  // UseCases
  sl.registerLazySingleton(() => AddReceiptUseCase(sl()));
  sl.registerLazySingleton(() => GetReceiptUseCase(sl()));
  sl.registerLazySingleton(() => GetReceiptsUseCase(sl()));
  sl.registerLazySingleton(() => GetReceiptsInReceiptMonthUseCase(sl()));
  sl.registerLazySingleton(() => RemoveReceiptUseCase(sl()));
  sl.registerLazySingleton(() => UpdateReceiptUseCase(sl()));
  sl.registerLazySingleton(() => GetTotalAmountOfReceiptsUseCase());

  sl.registerLazySingleton(() => GetAmountOfReceiptsUseCase());
  sl.registerLazySingleton(() => FilterReceiptByTypeUseCase());
  sl.registerLazySingleton(() => GetIncomesOutcomesUseCase(sl(), sl()));

  // BLoC
  sl.registerLazySingleton(
    () => ReceiptsBloc(
        addReceiptUseCase: sl(),
        getReceiptsUseCase: sl(),
        getReceiptsInReceiptMonthUseCase: sl(),
        updateReceiptUseCase: sl(),
        removeReceiptUseCase: sl(),
        searchBloc: sl()),
  );
}

void _initContacts(String userId) {
  //
  // Contacts
  //

  // DataSources
  sl.registerLazySingleton<ContactsLocalMobileDataSource>(
      () => ContactsLocalMobileDataSourceMoorImpl(sl(), sl()));

  sl.registerLazySingleton<ContactsRemoteFirebaseDataSource>(
      () => ContactsRemoteFirebaseDataSourceDefaultImpl(sl(), userId));

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

void _initFields() {
  sl.registerLazySingleton<FieldsLocalMobileDataSource>(
      () => FieldsLocalMobileDataSourceMoorImpl(sl()));
}

void _initAuthAndAccounts() {
  // Auth Usecases

  sl.registerLazySingleton<SendResetPasswordEmailUseCase>(
      () => SendResetPasswordEmailUseCase(sl()));

  sl.registerLazySingleton<SignInWithEmailAndPasswordUseCase>(
      () => SignInWithEmailAndPasswordUseCase(sl(), sl()));

  sl.registerLazySingleton(() => SignInAnonymouslyUseCase(sl(), sl(), sl()));

  sl.registerLazySingleton<RegisterWithEmailAndPasswordUseCase>(
      () => RegisterWithEmailAndPasswordUseCase(sl(), sl(), sl()));

  sl.registerLazySingleton<GetSignInStateUseCase>(
      () => GetSignInStateUseCase(sl()));

  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl(), sl()));

  sl.registerLazySingleton<UpdateUserPasswordUseCase>(
      () => UpdateUserPasswordUseCase(sl()));

  // Account UseCases

  sl.registerLazySingleton(() => CreateAccountUseCase(sl()));

  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

  sl.registerLazySingleton(() => GetAccountUseCase(sl()));

  sl.registerLazySingleton(
      () => UpdateAccountUseCase(sl(), firebaseAuth: sl()));

  // Repositories

  sl.registerLazySingleton<AccountsRepository>(
      () => AccountsRepositoryDefaultFirebaseImpl(sl()));

  // Blocs

  sl.registerSingleton<AuthBloc>(AuthBloc(getSignInStateUseCase: sl()));

  sl.registerSingleton<AccountsBloc>(
    AccountsBloc(
      createAccountUseCase: sl(),
      deleteAccountUseCase: sl(),
      getAccountUseCase: sl(),
      updateAccountUseCase: sl(),
    ),
  );
}

void _initFirebase() {
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<Firestore>(Firestore.instance);
}

void _initConfig() {
  sl.registerLazySingleton<Config>(() => ConfigDefaultImpl(sl()));
}

Future _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

void _initMoorDatabase() {
  sl.registerSingleton<QueryExecutor>(
    FlutterQueryExecutor.inDatabaseFolder(path: "data.sqlit"),
  );

  sl.registerSingleton(MoorAppDatabase(sl()));
}
