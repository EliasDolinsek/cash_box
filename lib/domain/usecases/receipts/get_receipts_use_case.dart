import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/usecases/UseCase.dart';
import 'package:dartz/dartz.dart';

class GetReceiptsUseCase extends UseCase<List<Receipt>, NoParams> {

  final ReceiptsRepository receiptsRepository;

  GetReceiptsUseCase(this.receiptsRepository);

  @override
  Future<Either<Failure, List<Receipt>>> call(NoParams params) async {
    return receiptsRepository.getReceipts();
  }


}