import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:cash_box/domain/repositories/buckets_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

class GetBucketsUseCase extends UseCase<List<Bucket>, NoParams> {

  final BucketsRepository repository;

  GetBucketsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Bucket>>> call(NoParams params) async {
    return repository.getBuckets();
  }

}