import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/auth_bloc/auth_bloc.dart';
import 'package:cash_box/app/auth_bloc/auth_event.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/account/usecases/register_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/account/usecases/send_reset_password_email_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class SignInInputWidget extends StatefulWidget {
  @override
  _SignInInputWidgetState createState() => _SignInInputWidgetState();
}

class _SignInInputWidgetState extends State<SignInInputWidget> {
  SignInType _signInType = SignInType.sign_in;
  AccountType _accountType = AccountType.private;

  String _signInFailureMessage;

  String _nameErrorText;
  String _name;

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildNameInput(),
        _buildEmailTextField(),
        SizedBox(height: 16.0),
        _buildPasswordsTextFields(),
        _buildAccountTypeInput(),
        SizedBox(height: 16.0),
        _buildSignInFailureText(),
        SizedBox(height: 8.0),
        _buildSignInBar(),
        SizedBox(height: 16.0),
        _buildSwitchSignInTypeButton(),
      ],
    );
  }

  Widget _buildAccountTypeInput() {
    if (_signInType == SignInType.register) {
      return Column(
        children: <Widget>[SizedBox(height: 16.0), _buildAccountTypeSwitch()],
      );
    } else {
      return Container();
    }
  }

  Widget _buildAccountTypeSwitch() {
    return CheckboxListTile(
      value: _accountType == AccountType.business,
      onChanged: (value) {
        setState(() {
          if (value) {
            _accountType = AccountType.business;
          } else {
            _accountType = AccountType.private;
          }
        });
      },
      title: Text("Create busniess account"),
      subtitle: Text(
          "Create a bussiness account if this will not be for private use only"),
    );
  }

  Widget _buildNameInput() {
    if (_signInType == SignInType.register) {
      return Column(
        children: <Widget>[_buildNameTextField(), SizedBox(height: 16.0)],
      );
    } else {
      return Column();
    }
  }

  Widget _buildNameTextField() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: AppLocalizations.translateOf(context, "sign_in_page_name"),
        hintText:
            AppLocalizations.translateOf(context, "sing_in_page_name_hint"),
        errorText: _nameErrorText,
      ),
      onChanged: (text) {
        setState(() {
          _clearFailures();
          _name = text;
        });
      },
    );
  }

  Widget _buildSignInFailureText() {
    if (_signInFailureMessage != null && _signInFailureMessage.isNotEmpty) {
      return Text(_signInFailureMessage, style: TextStyle(color: Colors.red));
    } else {
      return Container();
    }
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
          _clearFailures();
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
          errorText: _passwordErrorText),
      onChanged: (text) {
        setState(() => _password = text);
      },
      obscureText: true,
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
          errorText: _passwordConformationErrorText),
      onChanged: (text) {
        setState(() => _passwordConformation = text);
      },
      obscureText: true,
    );
  }

  Widget _buildSignInBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildForgotPasswordButton(),
        _buildSignInCreateAccountButton(),
      ],
    );
  }

  Widget _buildForgotPasswordButton() {
    return MaterialButton(
        child: Text(AppLocalizations.translateOf(
            context, "sign_in_page_btn_forgot_password")),
        onPressed:
            _signInType == SignInType.sign_in ? _checkAndSendResetEmail : null);
  }

  Widget _buildSignInCreateAccountButton() {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      child: Text(
        _getSignInRegisterText(),
      ),
      onPressed: () {
        if (_signInType == SignInType.sign_in) {
          _checkAndSignInWithEmailAndPassword();
        } else {
          _checkAndRegister();
        }
      },
    );
  }

  void _checkAndRegister() {
    _email = _email.trim();

    final nameError = InputConverter.validateName(context, _name);
    final emailError = InputConverter.validateEmail(context, _email);
    final passwordError = InputConverter.validatePassword(context, _password);
    final passwordConfirmationError =
        InputConverter.validatePasswordConfirmation(
            context, _password, _passwordConformation);

    if (emailError != null ||
        passwordError != null ||
        passwordConfirmationError != null ||
        nameError != null) {
      setState(() {
        _nameErrorText = nameError;
        _emailErrorText = emailError;
        _passwordErrorText = passwordError;
        _passwordConformationErrorText = passwordConfirmationError;
      });
    } else {
      setState(() => _clearFailures());
      _register();
    }
  }

  void _register() async {
    final useCase = sl<RegisterWithEmailAndPasswordUseCase>();
    final params = RegisterWithEmailAndPasswordUseCaseParams(_email, _password);

    _showLoadingSnackbar();
    final result = await useCase(params);

    result.fold((failure) => _displayRegisterFailure(), (userID) {
      _createAccount(userID);
      sl<AuthBloc>().dispatch(LoadAuthStateEvent());
      Navigator.of(context).pushNamed("/tutorial", arguments: _name);
    });
  }

  void _createAccount(String userID) {
    final accountsBloc = sl<AccountsBloc>();
    final account = _getAccountFromEnteredDetails(userID);
    final event = CreateAccountEvent(account);

    accountsBloc.dispatch(event);
  }

  Account _getAccountFromEnteredDetails(String userID) {
    return Account(
      userID: userID,
      signInSource: SignInSource.firebase,
      accountType: _accountType,
      email: _email,
      appPassword: "",
      name: _name,
      currencyCode: "USD",
      subscriptionInfo: SubscriptionInfo(
        subscriptionType: _getSubscriptionTypeFromAccountType(),
        purchaseDate: DateTime.now(),
      ),
    );
  }

  SubscriptionType _getSubscriptionTypeFromAccountType() {
    if (_accountType == AccountType.private) {
      return SubscriptionType.personal_free;
    } else if (_accountType == AccountType.business) {
      return SubscriptionType.business_free;
    } else {
      return null;
    }
  }

  void _displayRegisterFailure() {
    final text =
        AppLocalizations.translateOf(context, "sign_in_page_register_failure");
    setState(() => _signInFailureMessage = text);
  }

  String _getSignInRegisterText() {
    final appLocalizations = AppLocalizations.of(context);
    if (_signInType == SignInType.sign_in) {
      return appLocalizations.translate("sign_in_page_btn_sign_in");
    } else {
      return appLocalizations.translate("sign_in_page_btn_register");
    }
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
      setState(_clearFailures);
    }
  }

  Future _signInWithEmailAndPassword() async {
    final useCase = sl<SignInWithEmailAndPasswordUseCase>();
    final params = SignInWithEmailAndPasswordUseCaseParams(_email, _password);

    _showLoadingSnackbar();
    final result = await useCase(params);

    result.fold((failure) {
      if (failure is SignInFailure) {
        _displaySignInFailure(failure);
      } else {
        setState(
          () => _signInFailureMessage =
              _getErrorMessageForSignInFailureType(null),
        );
      }
    }, (_) {
      sl<AuthBloc>().dispatch(LoadAuthStateEvent());
    });
  }

  void _clearFailures() {
    _nameErrorText = null;
    _signInFailureMessage = null;
    _emailErrorText = null;
    _passwordErrorText = null;
    _passwordConformationErrorText = null;
  }

  void _displaySignInFailure(SignInFailure failure) {
    final errorMessage = _getErrorMessageForSignInFailureType(failure.type);
    setState(() => _signInFailureMessage = errorMessage);
  }

  String _getErrorMessageForSignInFailureType(SignInFailureType type) {
    final appLocalizations = AppLocalizations.of(context);
    if (type == SignInFailureType.user_not_found) {
      return appLocalizations
          .translate("sign_in_widget_sign_in_user_not_found");
    } else if (type == SignInFailureType.wrong_password) {
      return appLocalizations.translate("sign_in_widget_wrong_password");
    } else {
      return appLocalizations.translate("sign_in_widget_sign_in_failure");
    }
  }

  void _checkAndSendResetEmail() {
    if (_email.isEmpty) {
      _showEnterEmailError();
    } else {
      final error = InputConverter.validateEmail(context, _email);
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

  void _showLoadingSnackbar() {
    final text = AppLocalizations.translateOf(context, "sing_in_page_loading");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void _showSendingEmailSnackbar() {
    final text =
        AppLocalizations.translateOf(context, "sing_in_page_sending_email");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void _showResetEmailErrorSnackbar() {
    final text =
        AppLocalizations.translateOf(context, "sing_in_page_reset_email_error")
            .replaceAll("%{email}", _email);
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
