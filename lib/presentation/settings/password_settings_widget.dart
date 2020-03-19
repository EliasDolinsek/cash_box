import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/domain/account/usecases/update_password_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/re_sign_in_dialog.dart';
import 'package:flutter/material.dart';

class PasswordSettingsWidget extends StatefulWidget {
  @override
  _PasswordSettingsWidgetState createState() => _PasswordSettingsWidgetState();
}

class _PasswordSettingsWidgetState extends State<PasswordSettingsWidget> {
  String _errorText;
  String _passwordErrorText;
  String _passwordConfirmationErrorText;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(_clearErrors);
    _passwordConfirmationController.addListener(_clearErrors);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildErrorText(),
        _buildPasswordField(),
        SizedBox(height: 16.0),
        _buildPasswordConfirmationField(),
        SizedBox(height: 16.0),
        _buildUpdatePasswordButton()
      ],
    );
  }

  Widget _buildErrorText() {
    if (_errorText != null && _errorText.isNotEmpty) {
      return Column(
        children: <Widget>[
          Text(_errorText, style: TextStyle(color: Colors.red)),
          SizedBox(height: 16)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "New password",
        hintText: "Enter a new password",
        errorText: _passwordErrorText,
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }

  Widget _buildPasswordConfirmationField() {
    return TextField(
      controller: _passwordConfirmationController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Confirm password",
          hintText: "Confirm new password",
          errorText: _passwordConfirmationErrorText),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }

  Widget _buildUpdatePasswordButton() {
    return MaterialButton(
      onPressed: _checkAndUpdate,
      child: Text("UPDATE PASWORD"),
    );
  }

  void _checkAndUpdate() async {
    final passwordErrorText =
        InputConverter.validatePassword(context, _passwordController.text);

    final passwordConfirmationErrorText =
        InputConverter.validatePasswordConfirmation(
      context,
      _passwordController.text,
      _passwordConfirmationController.text,
    );

    if (passwordErrorText != null || passwordConfirmationErrorText != null) {
      setState(() {
        _passwordErrorText = passwordErrorText;
        _passwordConfirmationErrorText = passwordConfirmationErrorText;
      });
    } else {
      if(await _showReSignInDialog()){
        _updatePassword();
      }
    }
  }

  Future<bool> _showReSignInDialog() async {
    return await showDialog(context: context, builder: (_) => ReSignInDialog());
  }

  void _updatePassword() async {
    final useCase = sl<UpdateUserPasswordUseCase>();
    final params = UpdateUserPasswordUseCaseParams(_passwordController.text);

    _showUpdatingPasswordSnackbar();
    final result = await useCase(params);

    result.fold((_) {
      setState(() {
        _errorText = AppLocalizations.translateOf(
            context, "password_settings_widget_error");
      });
    }, (_){
      _showPasswordUpdatedSnackbar();
    });
  }

  void _showUpdatingPasswordSnackbar(){
    final text = AppLocalizations.translateOf(context, "password_settings_widget_updating_password");
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _showPasswordUpdatedSnackbar(){
    final text = AppLocalizations.translateOf(context, "password_settings_widget_password_updated");
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _clearErrors() {
    setState(() {
      _errorText = null;
      _passwordErrorText = null;
      _passwordConfirmationErrorText = null;
    });
  }
}
