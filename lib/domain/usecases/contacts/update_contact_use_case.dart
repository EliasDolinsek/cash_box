import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateContactUseCase extends UseCase<EmptyData, UpdateContactUseCaseParams> {
  @override
  Future<Either<Failure, EmptyData>> call(UpdateContactUseCaseParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class UpdateContactUseCaseParams extends Equatable {

}