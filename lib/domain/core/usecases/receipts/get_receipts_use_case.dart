import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:dartz/dartz.dart';

import '../use_case.dart';

class GetReceiptsUseCase extends UseCase<List<Receipt>, NoParams> {

  final ReceiptsRepository receiptsRepository;

  GetReceiptsUseCase(this.receiptsRepository);

  @override
  Future<Either<Failure, List<Receipt>>> call(NoParams params) async {
    return receiptsRepository.getReceipts();
  }


}