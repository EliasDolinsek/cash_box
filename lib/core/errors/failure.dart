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