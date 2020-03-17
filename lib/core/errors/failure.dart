import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class ReceiptNotFoundFailure extends Failure {}

class TemplateNotFoundFailure extends Failure {}

class BucketNotFoundFailure extends Failure {}

class ContactNotFoundFailure extends Failure {}

class ReceiptsNotFoundFailure extends Failure {}

class TagNotFoundFailure extends Failure {}

class LocalDataSourceFailure extends Failure {}

class DataStorageLocationFailure extends Failure {}

class RepositoryFailure extends Failure {}

class SendResetPasswordEmailFailure extends Failure {}

class SignInFailure extends Failure {

  final SignInFailureType type;

  SignInFailure(this.type) : super([type]);

  @override
  List get props => [type];
}

enum SignInFailureType { user_not_found, wrong_password, other}

class SignOutFailure extends Failure {}

class AccountsRepositoryFailure extends Failure {}

class FirebaseFailure extends Failure {}