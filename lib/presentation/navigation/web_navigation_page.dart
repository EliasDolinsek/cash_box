import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/auth_bloc/auth_bloc.dart';
import 'package:cash_box/app/auth_bloc/auth_event.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/usecases/get_user_id_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_out_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

import 'navigation_config.dart' as config;

class WebNavigationPage extends StatefulWidget {
  @override
  _WebNavigationPageState createState() => _WebNavigationPageState();
}

class _WebNavigationPageState extends State<WebNavigationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CashBox"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: config.page,
      ),
      drawer: Builder(
        builder: (context) => Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 16.0),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: config.getColorForNavigationPage("overviewWidget", context),
                ),
                title: Text(
                  AppLocalizations.translateOf(context, "navigation_overview"),
                  style: TextStyle(
                    color: config.getColorForNavigationPage("overviewWidget", context),
                  ),
                ),
                onTap: () {
                  setState(() => config.selectedPage = "overviewWidget");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.search,
                  color: config.getColorForNavigationPage("searchWidget", context),
                ),
                title: Text(
                  AppLocalizations.translateOf(context, "navigation_search"),
                  style: TextStyle(
                    color: config.getColorForNavigationPage("searchWidget", context),
                  ),
                ),
                onTap: () {
                  setState(() => config.selectedPage = "searchWidget");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.trending_up,
                  color: config.getColorForNavigationPage("statisticsWidget", context),
                ),
                title: Text(
                  AppLocalizations.translateOf(context, "navigation_statistics"),
                  style: TextStyle(
                    color: config.getColorForNavigationPage("statisticsWidget", context),
                  ),
                ),
                onTap: () {
                  setState(() => config.selectedPage = "statisticsWidget");
                  Navigator.pop(context);
                },
              ),
              Expanded(child: Container()),
              _buildUserChip(),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: config.getColorForNavigationPage("settingsWidget", context),
                ),
                title: Text(
                  AppLocalizations.translateOf(context, "navigation_settings"),
                  style: TextStyle(
                    color: config.getColorForNavigationPage("settingsWidget", context),
                  ),
                ),
                onTap: () {
                  setState(() => config.selectedPage = "settingsWidget");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                title: Text(AppLocalizations.translateOf(context, "navigation_sign_out")),
                onTap: () {
                  _signOut(context);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserChip() {
    final authBloc = sl<AccountsBloc>();
    return StreamBuilder(
      stream: authBloc.state,
      builder: (_, AsyncSnapshot<AccountsState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is InitialAccountsState) {
            _getUserID().then((userID) {
              authBloc.dispatch(GetAccountEvent(userID));
            });
            return _buildUseChipWithText(AppLocalizations.translateOf(context, "navigation_loading"));
          } else if (data is AccountAvailableState) {
            return _buildUseChipWithText(data.account.email);
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Future<String> _getUserID() async {
    final user = await sl<GetUserIdUserCase>()(NoParams());
    return user.fold((l) => null, (uid) => uid);
  }

  Widget _buildUseChipWithText(String text) {
    return Chip(label: Text(text));
  }

  void _signOut(BuildContext context) {
    final userCase = sl<SignOutUseCase>();
    _showSigningOutSnackbar(context);
    userCase(NoParams()).then((value) {
      sl<AuthBloc>().dispatch(LoadAuthStateEvent());
    });
  }

  void _showSigningOutSnackbar(BuildContext scaffoldContext){
    final text = AppLocalizations.translateOf(context, "navigation_page_signing_out");
    Scaffold.of(scaffoldContext).showSnackBar(SnackBar(content: Text(text)));
  }
}
