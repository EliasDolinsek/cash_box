import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/usecases/get_user_id_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class NameEmailSettingsWidget extends StatefulWidget {
  @override
  _NameEmailSettingsWidgetState createState() =>
      _NameEmailSettingsWidgetState();
}

class _NameEmailSettingsWidgetState extends State<NameEmailSettingsWidget> {

  bool _setup = false;
  String _nameError, _emailError;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accountsBloc = sl<AccountsBloc>();
    return StreamBuilder(
      stream: accountsBloc.state,
      builder: (_, AsyncSnapshot<AccountsState> snaphsot) {
        if (snaphsot.hasData) {
          final data = snaphsot.data;
          if (data is AccountAvailableState) {
            if(!_setup){
              _setDataFromAccountAvailableState(data);
              _setup = true;
            }
            return _buildLoaded();
          } else {
            _getAccountEvent(accountsBloc);
            return _buildLoading();
          }
        } else {
          _getAccountEvent(accountsBloc);
          return _buildLoading();
        }
      },
    );
  }

  void _setDataFromAccountAvailableState(AccountAvailableState state) {
    _nameController.text = state.account.name;
    _emailController.text = state.account.email;
  }

  void _getAccountEvent(AccountsBloc bloc) {
    _getUserID().then((value) => () {
          bloc.dispatch(GetAccountEvent(value));
        });
  }

  Future<String> _getUserID() async {
    final useCase = sl<GetUserIdUserCase>();
    final result = await useCase(NoParams());
    return result.fold((l) => null, (r) => r);
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildLoaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildNameField(),
        SizedBox(height: 16.0),
        _buildEmailField(),
        SizedBox(height: 8.0),
        _buildUpdateButton()
      ],
    );
  }

  Widget _buildUpdateButton() {
    return MaterialButton(
      child: Text(AppLocalizations.translateOf(context, "name_email_settings_widget_btn_update_details")),
      onPressed: _checkAndUpdateDetails,
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: AppLocalizations.translateOf(context, "name_email_settings_widget_name"),
          hintText: AppLocalizations.translateOf(context, "name_email_settings_widget_name_hint"),
          errorText: _nameError),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: AppLocalizations.translateOf(context, "name_email_settings_widget_email"),
          hintText: AppLocalizations.translateOf(context, "name_email_settings_widget_email_hint"),
          errorText: _emailError),
    );
  }

  void _checkAndUpdateDetails() {
    final nameError =
        InputConverter.validateName(context, _nameController.text);
    final emailError =
        InputConverter.validateEmail(context, _emailController.text);

    if (nameError != null || emailError != null) {
      setState(() {
        _nameError = nameError;
        _emailError = emailError;
      });
    } else {
      _clearErrors();
      _updateDetails();
      _updateDetails();
    }
  }

  void _updateDetails() async {
    final userID = await _getUserID();
    final event = UpdateAccountEvent(
      userID,
      name: _nameController.text,
      email: _emailController.text,
    );

    final accountsBloc = sl<AccountsBloc>();

    accountsBloc.dispatch(event);
    accountsBloc.dispatch(GetAccountEvent(userID));
  }

  void _clearErrors() {
    setState(() {
      _nameError = null;
      _emailError = null;
    });
  }
}
