import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/accounts_event.dart';
import 'package:cash_box/app/auth_bloc/auth_bloc.dart';
import 'package:cash_box/app/auth_bloc/bloc.dart';
import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/purchases_bloc/purchases_bloc.dart';
import 'package:cash_box/app/purchases_bloc/purchases_event.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/app/search_bloc/bloc.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/domain/account/usecases/sign_out_use_case.dart';
import 'package:cash_box/domain/core/usecases/notify_repositories_user_id_changed_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future signOut() async {
  final userCase = sl<SignOutUseCase>();
  await userCase(NoParams());

  final notifyUserIdChangedUseCase = sl<NotifyRepositoriesUserIdChangedUseCase>();
  final params = NotifyRepositoriesUserIdChangedUseCaseParams(null);
  notifyUserIdChangedUseCase.call(params);

  sl<AuthBloc>().dispatch(LoadAuthStateEvent());
  sl<AccountsBloc>().dispatch(GetAccountEvent());
  sl<BucketsBloc>().dispatch(GetBucketsEvent());
  sl<ContactsBloc>().dispatch(GetContactsEvent());
  sl<ReceiptsBloc>().dispatch(GetReceiptsOfMonthEvent());
  sl<SearchBloc>().dispatch(ReceiptsSearchEvent(DateTime.now()));
  sl<TagsBloc>().dispatch(GetTagsEvent());
  sl<TemplatesBloc>().dispatch(GetTemplatesEvent());
  sl<PurchasesBloc>().dispatch(GetCurrentSubscriptionEvent(null));
}

void showSigningOutSnackbar(BuildContext context) {
  final text = AppLocalizations.translateOf(
    context,
    "navigation_page_signing_out",
  );
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
}
