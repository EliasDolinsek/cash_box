import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedInAuthState extends AuthState {}

class SignedOutAuthState extends AuthState {}

class AuthErrorState extends AuthState {

  final String errorMessage;

  AuthErrorState(this.errorMessage);

  @override
  List get props => [errorMessage];
}