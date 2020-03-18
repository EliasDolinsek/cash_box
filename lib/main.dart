import 'package:cash_box/domain/account/enteties/sign_in_state.dart';
import 'package:cash_box/presentation/auth/sign_in_page.dart';
import 'package:cash_box/presentation/navigation/navigation_page.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/auth_bloc/auth_bloc.dart';
import 'app/auth_bloc/bloc.dart';
import 'app/injection.dart' as injection;
import 'app/injection.dart';
import 'localizations/app_localizations.dart';

void main() async {
  await injection.init();
  runApp(CashBoxApp());
}

class CashBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CashBox",
      supportedLocales: [
        Locale("en", "EN"),
        Locale("de", "DE"),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocal in supportedLocales) {
          if (supportedLocal.languageCode == locale.languageCode){
            return supportedLocal;
          }
        }

        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.tealAccent
      ),
      home: _buildHome(),
    );
  }

  Widget _buildHome(){
    final authBloc = sl<AuthBloc>();
    return StreamBuilder(
      stream: authBloc.state,
      builder: (_, AsyncSnapshot<AuthState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is InitialAuthState) {
            authBloc.dispatch(LoadAuthStateEvent());
            return LoadingWidget();
          } else if (data is SignInStateAvailable) {
            return _buildWidgetForSignInState(data.signInState);
          } else {
            return Expanded(child: LoadingWidget());
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildWidgetForSignInState(SignInState state) {
    if (state == SignInState.signedOut) {
      return SignInPage();
    } else {
      return NavigationPage();
    }
  }
}
