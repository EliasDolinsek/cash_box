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

  final AuthErrorType type;

  AuthErrorState(this.type);

  @override
  List get props => [type];
}

class LoadingAuthState extends AuthState {}

enum AuthErrorType { firebaseError, other }