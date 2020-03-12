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

  final String message;

  SignInFailure(this.message) : super([message]);
}

class SignOutFailure extends Failure {}

class AccountsRepositoryFailure extends Failure {}