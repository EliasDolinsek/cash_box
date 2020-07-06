import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/repositories/repository.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:dartz/dartz.dart';

import 'empty_data.dart';

abstract class BucketsRepository implements Repository{

  Future<Either<Failure, EmptyData>> addBucket(Bucket bucket);
  Future<Either<Failure, EmptyData>> updateBucket(String id, Bucket bucket);
  Future<Either<Failure, EmptyData>> removeBucket(String id);

  Future<Either<Failure, List<Bucket>>> getBuckets();
}