import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/usecases/get_user_id_use_case.dart';
import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/re_sign_in_dialog.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class NameEmailSettingsWidget extends StatefulWidget {
  @override
  _NameEmailSettingsWidgetState createState() =>
      _NameEmailSettingsWidgetState();
}

class _NameEmailSettingsWidgetState extends State<NameEmailSettingsWidget> {
  bool _setup = false;
  String _nameError, _emailError, _errorText;

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
            if (!_setup) {
              _setDataFromAccountAvailableState(data);
              _setup = true;
            }
            return _buildLoaded();
          } else {
            _getAccountEvent(accountsBloc);
            return LoadingWidget();
          }
        } else {
          _getAccountEvent(accountsBloc);
          return LoadingWidget();
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

  Widget _buildLoaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildErrorText(),
        _buildNameField(),
        SizedBox(height: 16.0),
        _buildEmailField(),
        SizedBox(height: 8.0),
        _buildUpdateButton()
      ],
    );
  }

  Widget _buildErrorText() {
    if (_errorText != null) {
      return Column(
        children: <Widget>[
          Text(
            _errorText,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16.0),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildUpdateButton() {
    return MaterialButton(
      child: Text(AppLocalizations.translateOf(
          context, "name_email_settings_widget_btn_update_details")),
      onPressed: _checkAndUpdateDetails,
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: AppLocalizations.translateOf(
              context, "name_email_settings_widget_name"),
          hintText: AppLocalizations.translateOf(
              context, "name_email_settings_widget_name_hint"),
          errorText: _nameError),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: AppLocalizations.translateOf(
              context, "name_email_settings_widget_email"),
          hintText: AppLocalizations.translateOf(
              context, "name_email_settings_widget_email_hint"),
          errorText: _emailError),
    );
  }

  void _checkAndUpdateDetails() async {
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
      if (await _showReSignInDialog()) {
        _clearErrors();
        _updateDetails();
      }
    }
  }

  Future<bool> _showReSignInDialog() async {
    return await showDialog(context: context, builder: (_) => ReSignInDialog());
  }

  void _updateDetails() async {
    final userID = await _getUserID();
    final params = UpdateAccountUseCaseParams(userID,
        name: _nameController.text, email: _emailController.text);

    _showUpdatingDetailsSnackbar();
    final useCase = sl<UpdateAccountUseCase>();
    final result = await useCase(params);

    result.fold((_) {
      setState(() {
        _errorText = AppLocalizations.translateOf(
            context, "name_email_settings_widget_error_updating");
      });
    }, (_) => _showUpdatedDetailsSnackbar());
  }

  void _clearErrors() {
    setState(() {
      _errorText = null;
      _nameError = null;
      _emailError = null;
    });
  }

  void _showUpdatingDetailsSnackbar(){
    final text = AppLocalizations.translateOf(context, "name_email_settings_widget_updating");
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _showUpdatedDetailsSnackbar(){
    final text = AppLocalizations.translateOf(context, "name_email_settings_widget_updated_details");
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
