import 'package:cash_box/domain/account/enteties/sign_in_state.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignInStateAvailable extends AuthState {

  final SignInState signInState;

  SignInStateAvailable(this.signInState);

  @override
  List get props => [signInState];
}

class AuthErrorState extends AuthState {

  final String errorMessage;

  AuthErrorState(this.errorMessage);

  @override
  List get props => [errorMessage];
}