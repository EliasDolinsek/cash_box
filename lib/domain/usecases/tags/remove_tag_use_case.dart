import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/repositories/receipts_repository.dart';
import 'package:cash_box/domain/repositories/tags_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveTagUseCase extends UseCase<EmptyData, RemoveTagUseCaseParams> {

  final TagsRepository tagsRepository;
  final ReceiptsRepository receiptsRepository;

  RemoveTagUseCase(this.tagsRepository, this.receiptsRepository);

  @override
  Future<Either<Failure, EmptyData>> call(RemoveTagUseCaseParams params) async {
    final receiptsEither = await receiptsRepository.getReceipts();
    final receiptsList = receiptsEither.fold((failure) => Left(failure), (receipts) => receipts);

    if(receiptsList is Failure){
      return Left(receiptsList);
    } else if(receiptsList is List<Receipt>){
      _removeTagsFromReceipts(params.id, receiptsList);
      return tagsRepository.removeTag(params.id);
    } else {
      return Left(ReceiptsNotFoundFailure());
    }
  }

  void _removeTagsFromReceipts(String tagID, List<Receipt> receipts){
    receipts.forEach((receipt){
      receipt.tagIDs.remove(tagID);
      receiptsRepository.updateReceipt(receipt.id, receipt);
    });
  }

}

class RemoveTagUseCaseParams extends Equatable {

  final String id;

  RemoveTagUseCaseParams(this.id) : super([id]);
}