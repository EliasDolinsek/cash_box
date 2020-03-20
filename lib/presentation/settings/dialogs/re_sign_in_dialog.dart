import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/usecases/get_user_id_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ReSignInDialog extends StatefulWidget {
  @override
  _ReSignInDialogState createState() => _ReSignInDialogState();
}

class _ReSignInDialogState extends State<ReSignInDialog> {
  String _email;
  String _errorText;

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        _errorText = null;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.translateOf(context, "re_sign_in_dialog_hint_password")),
      content: _buildContent(),
      actions: _buildActions(),
    );
  }

  List<Widget> _buildActions() {
    return [
      MaterialButton(
          child: Text(AppLocalizations.translateOf(context, "dialog_btn_cancel")),
          onPressed: () {
            Navigator.pop(context, false);
          }),
      MaterialButton(
        child: Text(AppLocalizations.translateOf(context, "dialog_btn_confirm")),
        onPressed: _email != null ? _checkAndReSignIn : null,
      ),
    ];
  }

  Widget _buildContent() {
    final accountsBloc = sl<AccountsBloc>();
    return StreamBuilder(
      stream: accountsBloc.state,
      builder: (context, AsyncSnapshot<AccountsState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is AccountAvailableState) {
            _email = data.account.email;
            return _buildLoaded(data.account);
          } else {
            _callGetAccountEvent(accountsBloc);
            return _buildLoading();
          }
        } else {
          _callGetAccountEvent(accountsBloc);
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoaded(Account account) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          account.email,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        _buildPasswordInput()
      ],
    );
  }

  Widget _buildPasswordInput() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: AppLocalizations.translateOf(context, "re_sign_in_dialog_hint_password"),
        errorText: _errorText
      ),
      obscureText: true,
    );
  }

  void _callGetAccountEvent(AccountsBloc accountsBloc) {
    _getUserID().then((value) {
      if (value != null) {
        accountsBloc.dispatch(GetAccountEvent(value));
      }
    });
  }

  Future<String> _getUserID() async {
    final useCase = sl<GetUserIdUserCase>();
    final result = await useCase(NoParams());
    return result.fold((l) => null, (userID) => userID);
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  void _checkAndReSignIn() {
    final passwordError =
        InputConverter.validatePassword(context, _passwordController.text);

    if (passwordError != null) {
      setState(() {
        _errorText = passwordError;
      });
    } else {
      _signIn();
    }
  }

  void _signIn() async {
    final useCase = sl<SignInWithEmailAndPasswordUseCase>();
    final params = SignInWithEmailAndPasswordUseCaseParams(
        _email, _passwordController.text);
    final result = await useCase(params);

    result.fold((l) {
      setState(() {
        _errorText = AppLocalizations.translateOf(context, "re_sign_in_dialog_wrong_password");
      });
    }, (r) {
      Navigator.of(context).pop(true);
    });
  }
}
