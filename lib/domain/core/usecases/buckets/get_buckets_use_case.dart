import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/use_case.dart';

class GetBucketsUseCase extends UseCase<List<Bucket>, NoParams> {

  final BucketsRepository repository;

  GetBucketsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Bucket>>> call(NoParams params) async {
    return repository.getBuckets();
  }

}