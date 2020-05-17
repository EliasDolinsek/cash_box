import 'package:cash_box/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase {}

abstract class AsyncUseCase<Type, Params> extends UseCase {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class SyncUseCase<Type, Params> extends UseCase {
  Either<Failure, Type> call(Params params);
}

abstract class SecureSyncUseCase<Type, Params> extends UseCase {
  Type call(Params params);
}

class NoParams extends Equatable {
  NoParams({List params = const <dynamic>[]}) : super(params);
}
