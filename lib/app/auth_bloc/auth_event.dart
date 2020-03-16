import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class SendResetPasswordEmailEvent extends AuthEvent {

  final String email;

  SendResetPasswordEmailEvent(this.email);

  @override
  List get props => [email];

}

class SignInWithEmailAndPasswordEvent extends AuthEvent {

  final String email, password;

  SignInWithEmailAndPasswordEvent(this.email, this.password);

  @override
  List get props => [email, password];

}

class SignOutEvent extends AuthEvent {}

class LoadAuthEvent extends AuthEvent {}