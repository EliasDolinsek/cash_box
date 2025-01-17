import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

class GetBucketUseCase extends AsyncUseCase<Bucket, GetBucketUseCaseParams> {

  final BucketsRepository repository;

  GetBucketUseCase(this.repository);

  @override
  Future<Either<Failure, Bucket>> call(GetBucketUseCaseParams params) async {
    final bucketsEither = await repository.getBuckets();
    return bucketsEither.fold((failure) => Left(failure), (bucketsList){
      final bucket = _getBucket(params.id, bucketsList);
      if(bucket == null){
        return Left(BucketNotFoundFailure());
      } else {
        return Right(bucket);
      }
    });
  }

  Bucket _getBucket(String id, List<Bucket> buckets) {
    return buckets.firstWhere((b) => b.id == id, orElse: () => null);
  }

}

class GetBucketUseCaseParams extends Equatable {

  final String id;

  GetBucketUseCaseParams(this.id) : super([id]);
}