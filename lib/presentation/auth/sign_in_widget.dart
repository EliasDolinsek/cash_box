import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/domain/account/usecases/send_reset_password_email_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class SignInInputWidget extends StatefulWidget {
  @override
  _SignInInputWidgetState createState() => _SignInInputWidgetState();
}

class _SignInInputWidgetState extends State<SignInInputWidget> {
  SignInType _signInType = SignInType.sign_in;

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  String _emailErrorText;
  String _email = "";

  String _passwordErrorText;
  String _password = "";

  String _passwordConformationErrorText;
  String _passwordConformation = "";

  @override
  Widget build(BuildContext context) {
    return _buildMobile();
  }

  Widget _buildMobile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildEmailTextField(),
          SizedBox(height: 16.0),
          _buildPasswordsTextFields(),
          SizedBox(height: 16.0),
          _buildSignInBar(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildSwitchSignInTypeButton(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: AppLocalizations.translateOf(context, "sign_in_page_email"),
        hintText:
            AppLocalizations.translateOf(context, "sing_in_page_email_hint"),
        errorText: _emailErrorText,
      ),
      onChanged: (text) {
        setState(() {
          _emailErrorText = null;
          _email = text;
        });
      },
    );
  }

  Widget _buildPasswordsTextFields() {
    if (_signInType == SignInType.register) {
      return Column(
        children: <Widget>[
          _buildPasswordTextField(),
          SizedBox(height: 16.0),
          _buildConfirmPasswordTextField(),
        ],
      );
    } else {
      return _buildPasswordTextField();
    }
  }

  Widget _buildPasswordTextField() {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText:
              AppLocalizations.translateOf(context, "sign_in_page_password"),
          hintText: AppLocalizations.translateOf(
              context, "sign_in_page_password_hint"),
          suffixIcon: _buildShowPasswordIconButton(_hidePassword),
          errorText: _passwordErrorText),
      onChanged: (text) {
        setState(() => _password = text);
      },
      obscureText: _hidePassword,
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: AppLocalizations.translateOf(
              context, "sign_in_page_confirm_password"),
          hintText: AppLocalizations.translateOf(
              context, "sign_in_page_confirm_password_hint"),
          suffixIcon: _buildShowPasswordIconButton(_hideConfirmPassword),
          errorText: _passwordErrorText),
      onChanged: (text) {
        setState(() => _passwordConformation = text);
      },
      obscureText: _hideConfirmPassword,
    );
  }

  Widget _buildSignInBar() {
    if (_signInType == SignInType.sign_in) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildForgotPasswordButton(),
          _buildSignInCreateAccountButton(),
        ],
      );
    } else {
      return Align(
        alignment: Alignment.centerRight,
        child: _buildSignInCreateAccountButton(),
      );
    }
  }

  Widget _buildForgotPasswordButton() {
    return MaterialButton(
        child: Text(AppLocalizations.translateOf(
            context, "sign_in_page_btn_forgot_password")),
        onPressed: _checkAndSendResetEmail);
  }

  Widget _buildSignInCreateAccountButton() {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      child: Text(_getSignInRegisterText()),
      onPressed: () {
        if (_signInType == SignInType.sign_in) {
          _checkAndSignInWithEmailAndPassword();
        }
      },
    );
  }

  String _getSignInRegisterText() {
    final appLocalizations = AppLocalizations.of(context);
    if (_signInType == SignInType.sign_in) {
      return appLocalizations.translate("sign_in_page_btn_sign_in");
    } else {
      return appLocalizations.translate("sign_in_page_btn_register");
    }
  }

  Widget _buildShowPasswordIconButton(bool variable) {
    return IconButton(
      icon: Icon(Icons.remove_red_eye),
      onPressed: () {
        setState(() {
          variable = !variable;
        });
      },
    );
  }

  Widget _buildSwitchSignInTypeButton() {
    return MaterialButton(
      child: Text(_getButtonTextForSignInType()),
      onPressed: () {
        setState(() {
          if (_signInType == SignInType.sign_in) {
            _signInType = SignInType.register;
          } else {
            _signInType = SignInType.sign_in;
          }
        });
      },
    );
  }

  String _getButtonTextForSignInType() {
    final appLocalizations = AppLocalizations.of(context);
    if (_signInType == SignInType.sign_in) {
      return appLocalizations.translate("sign_in_page_btn_create_account");
    } else {
      return appLocalizations
          .translate("sign_in_page_btn_already_have_account");
    }
  }

  void _checkAndSignInWithEmailAndPassword() {
    final emailError = InputConverter.validateEmail(context, _email);
    final passwordError = InputConverter.validatePassword(context, _password);
    if (passwordError != null || emailError != null) {
      setState(() {
        _passwordErrorText = passwordError;
        _emailErrorText = emailError;
      });
    } else {
      _signInWithEmailAndPassword();
      setState(() {
        _passwordErrorText = null;
        _emailErrorText = null;
      });
    }
  }

  void _signInWithEmailAndPassword() {
    //final event = SignInWithEmailAndPasswordEvent(_email, _password);
    //sl<AuthBloc>().dispatch(event);
  }

  void _checkAndSendResetEmail() {
    if (_email.isEmpty) {
      _showEnterEmailError();
    } else {
      final error = InputConverter.validateEmail(context, _email);
      print(error);
      if (error == null) {
        _sendResetEmailAnClear(_email);
      } else {
        setState(() => _emailErrorText = error);
      }
    }
  }

  Future _sendResetEmailAnClear(String email) async {
    final useCase = sl<SendResetPasswordEmailUseCase>();
    final params = SendResetPasswordEmailUseCaseParams(email);

    _showSendingEmailSnackbar();
    final result = await useCase(params);

    result.fold((failure) {
      _showResetEmailErrorSnackbar();
    }, (_) {
      _showResetEmailSuccessfulSentSnackbar();
    });
  }

  void _showSendingEmailSnackbar(){
    final text =
    AppLocalizations.translateOf(context, "sing_in_page_sending_email");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void _showResetEmailErrorSnackbar() {
    final text =
        AppLocalizations.translateOf(context, "sing_in_page_reset_email_error").replaceAll("%{email}", _email);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void _showResetEmailSuccessfulSentSnackbar() {
    final text =
        AppLocalizations.translateOf(context, "sing_in_page_reset_email_sent")
            .replaceAll("%{email}", _email);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _showEnterEmailError() {
    final text =
        AppLocalizations.translateOf(context, "sing_in_page_enter_email");
    setState(() => _emailErrorText = text);
  }
}

enum SignInType { sign_in, register }
