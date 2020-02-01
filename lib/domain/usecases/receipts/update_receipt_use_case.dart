import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/usecases/UseCase.dart';
import 'package:dartz/dartz.dart';

class UpdateReceiptUseCase extends UseCase<void, UpdateReceiptUseCaseParams> {
  @override
  Future<Either<Failure, void>> call(UpdateReceiptUseCaseParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}

class UpdateReceiptUseCaseParams {

  
}