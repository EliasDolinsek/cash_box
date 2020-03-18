import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/auth_bloc/auth_bloc.dart';
import 'package:cash_box/app/auth_bloc/auth_event.dart';
import 'package:cash_box/app/auth_bloc/auth_state.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/usecases/get_user_id_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_out_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CashBox", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: _getBody(),
      drawer: Builder(
        builder: (context) => Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 16.0),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: getColorForTitleIndex(0),
                ),
                title: Text(
                  "Overview",
                  style: TextStyle(
                    color: getColorForTitleIndex(0),
                  ),
                ),
                onTap: () {
                  setState(() => _selectedIndex = 0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.search,
                  color: getColorForTitleIndex(1),
                ),
                title: Text(
                  "Search",
                  style: TextStyle(
                    color: getColorForTitleIndex(1),
                  ),
                ),
                onTap: () {
                  setState(() => _selectedIndex = 1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.trending_up,
                  color: getColorForTitleIndex(2),
                ),
                title: Text(
                  "Statistics",
                  style: TextStyle(
                    color: getColorForTitleIndex(2),
                  ),
                ),
                onTap: () {
                  setState(() => _selectedIndex = 2);
                  Navigator.pop(context);
                },
              ),
              Expanded(child: Container()),
              _buildUserChip(),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: getColorForTitleIndex(3),
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: getColorForTitleIndex(3),
                  ),
                ),
                onTap: () {
                  setState(() => _selectedIndex = 3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                title: Text("Sign Out"),
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
            return _buildUseChipWithText("Loading ...");
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

  Widget _getBody() {
    return Text("Site $_selectedIndex");
  }

  Color getColorForTitleIndex(int titleIndex) {
    if (titleIndex == _selectedIndex) {
      return Theme.of(context).primaryColorDark;
    } else {
      return Colors.black;
    }
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
