import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:dartz/dartz.dart';

import '../use_case.dart';

class GetBucketsUseCase extends AsyncUseCase<List<Bucket>, NoParams> {

  final BucketsRepository repository;

  GetBucketsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Bucket>>> call(NoParams params) async {
    return repository.getBuckets();
  }

}