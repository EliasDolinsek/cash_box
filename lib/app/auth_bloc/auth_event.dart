import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class SendResetPasswordEmailEvent extends Equatable {}

class SignInWithEmailAndPasswordEvent extends Equatable {

  final String email, password;

  SignInWithEmailAndPasswordEvent(this.email, this.password);

  @override
  List get props => [email, password];

}

class SignOutEvent extends Equatable {}

class LoadAuthEvent extends Equatable {}