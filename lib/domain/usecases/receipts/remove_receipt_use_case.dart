import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/usecases/UseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveReceiptUseCase extends UseCase<EmptyData, RemoveReceiptUseCaseParams> {

  final ReceiptsRepository receiptsRepository;

  RemoveReceiptUseCase(this.receiptsRepository);

  @override
  Future<Either<Failure, EmptyData>> call(RemoveReceiptUseCaseParams params) async {
    return receiptsRepository.removeReceipt(params.id);
  }

}

class RemoveReceiptUseCaseParams extends Equatable {

  final String id;

  RemoveReceiptUseCaseParams(this.id) : super([id]);
}