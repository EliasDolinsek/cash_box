import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class BucketsRepository {

  Future<Either<Failure, EmptyData>> addBucket(Bucket bucket);
  Future<Either<Failure, EmptyData>> updateBucket(String id, Bucket bucket);
  Future<Either<Failure, EmptyData>> removeBucket(String id);

  Future<Either<Failure, EmptyData>> addReceipt(String bucketID, String receiptID);
  Future<Either<Failure, EmptyData>> removeReceipt(String bucketID, String receiptID);

  Future<Either<Failure, List<Bucket>>> getBuckets();
}