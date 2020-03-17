import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class LoadAuthStateEvent extends AuthEvent {}