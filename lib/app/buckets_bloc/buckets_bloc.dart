import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_receipt_to_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/get_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/get_buckets_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/remove_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/remove_receipt_from_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/update_bucket_use_case.dart';
import './bloc.dart';

class BucketsBloc extends Bloc<BucketsEvent, BucketsState> {
  final AddBucketUseCase addBucketUseCase;
  final AddReceiptToBucketUseCase addReceiptToBucketUseCase;
  final GetBucketUseCase getBucketUseCase;
  final GetBucketsUseCase getBucketsUseCase;
  final RemoveBucketUseCase removeBucketUseCase;
  final RemoveReceiptFromBucketUseCase removeReceiptFromBucketUseCase;
  final UpdateBucketUseCase updateBucketUseCase;

  BucketsBloc(
      {this.addBucketUseCase,
      this.addReceiptToBucketUseCase,
      this.getBucketUseCase,
      this.getBucketsUseCase,
      this.removeBucketUseCase,
      this.removeReceiptFromBucketUseCase,
      this.updateBucketUseCase});

  @override
  BucketsState get initialState => InitialBucketsState();

  @override
  Stream<BucketsState> mapEventToState(
    BucketsEvent event,
  ) async* {
    if (event is AddBucketEvent) {
      final params = AddBucketUseCaseParams(event.bucket);
      await addBucketUseCase(params);
      dispatch(GetBucketsEvent());
    } else if (event is AddReceiptToBucketEvent) {
      final params =
          AddReceiptToBucketUseCaseParams(event.bucketID, event.receiptID);
      await addReceiptToBucketUseCase(params);
      dispatch(GetBucketsEvent());
    } else if (event is GetBucketEvent) {
      yield await _getBucket(event);
    } else if (event is GetBucketsEvent) {
      yield await _getBuckets(event);
    } else if (event is RemoveBucketEvent) {
      final params = RemoveBucketUseCaseParams(event.bucketID);
      await removeBucketUseCase(params);
      dispatch(GetBucketsEvent());
    } else if (event is RemoveReceiptFromBucketEvent) {
      final params =
          RemoveReceiptFromBucketUseCaseParams(event.receiptID, event.bucketID);
      await removeReceiptFromBucketUseCase(params);
      dispatch(GetBucketsEvent());
    } else if (event is UpdateBucketEvent) {
      final params = UpdateBucketUseCaseParams(event.id,
          name: event.name,
          description: event.description,
          receiptIDs: event.receiptIDs);

      await updateBucketUseCase(params);
      dispatch(GetBucketsEvent());
    }
  }

  Future<BucketsState> _getBuckets(GetBucketsEvent event) async {
    final bucketsEither = await getBucketsUseCase(NoParams());
    return bucketsEither.fold((l){
      return BucketsErrorState(l.toString());
    }, (buckets){
      return BucketsAvailableState(buckets);
    });
  }

  Future<BucketsState> _getBucket(GetBucketEvent event) async {
    final params = GetBucketUseCaseParams(event.bucketID);
    final bucketEither = await getBucketUseCase(params);
    return bucketEither.fold((l) async {
      return BucketsErrorState(l.toString());
    }, (bucket) async {
      return BucketAvailableState(bucket);
    });
  }
}
