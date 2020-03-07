import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/data/repositories/repository.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class BucketsRepository implements Repository{

  Future<Either<Failure, EmptyData>> addBucket(Bucket bucket);
  Future<Either<Failure, EmptyData>> updateBucket(String id, Bucket bucket);
  Future<Either<Failure, EmptyData>> removeBucket(String id);

  Future<Either<Failure, List<Bucket>>> getBuckets();
}