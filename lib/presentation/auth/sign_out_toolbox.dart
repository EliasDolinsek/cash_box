import 'package:cash_box/app/auth_bloc/auth_bloc.dart';
import 'package:cash_box/app/auth_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/account/usecases/sign_out_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void signOut() {
  final userCase = sl<SignOutUseCase>();
  userCase(NoParams()).then((value) {
    sl<AuthBloc>().dispatch(LoadAuthStateEvent());
  });
}

void showSigningOutSnackbar(BuildContext context) {
  final text = AppLocalizations.translateOf(
    context,
    "navigation_page_signing_out",
  );
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
}
