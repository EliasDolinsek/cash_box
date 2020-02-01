import 'package:cash_box/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase <Type, Params>{

  Future<Either<Failure, Type>> call(Params params);

}

class NoParams extends Equatable {

  NoParams({List params = const<dynamic>[]}) : super(params);

}