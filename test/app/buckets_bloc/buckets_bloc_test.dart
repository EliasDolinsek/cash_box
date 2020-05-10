import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_receipt_to_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/get_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/get_buckets_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/remove_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/remove_receipt_from_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/buckets/update_bucket_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/buckets_fixtures.dart';
import '../../fixtures/receipts_fixtures.dart';

class MockAddBucketUseCase extends Mock implements AddBucketUseCase {}

class MockAddReceiptToBucketUseCase extends Mock
    implements AddReceiptToBucketUseCase {}

class MockGetBucketsUseCase extends Mock implements GetBucketsUseCase {}

class MockGetBucketUseCase extends Mock implements GetBucketUseCase {}

class MockRemoveBucketUseCase extends Mock implements RemoveBucketUseCase {}

class MockRemoveReceiptFromBucketUseCase extends Mock
    implements RemoveReceiptFromBucketUseCase {}

class MockUpdateBucketUseCase extends Mock implements UpdateBucketUseCase {}

void main() {
  final MockAddBucketUseCase addBucketUseCase = MockAddBucketUseCase();
  final MockAddReceiptToBucketUseCase addReceiptToBucketUseCase =
      MockAddReceiptToBucketUseCase();
  final MockGetBucketsUseCase getBucketsUseCase = MockGetBucketsUseCase();
  final MockGetBucketUseCase getBucketUseCase = MockGetBucketUseCase();
  final MockRemoveBucketUseCase removeBucketUseCas = MockRemoveBucketUseCase();
  final MockRemoveReceiptFromBucketUseCase removeReceiptFromBucketUseCase =
      MockRemoveReceiptFromBucketUseCase();
  final MockUpdateBucketUseCase updateBucketUseCase = MockUpdateBucketUseCase();

  BucketsBloc bloc;

  setUp(() {
    bloc = BucketsBloc(
        addBucketUseCase: addBucketUseCase,
        addReceiptToBucketUseCase: addReceiptToBucketUseCase,
        getBucketsUseCase: getBucketsUseCase,
        getBucketUseCase: getBucketUseCase,
        removeBucketUseCase: removeBucketUseCas,
        removeReceiptFromBucketUseCase: removeReceiptFromBucketUseCase,
        updateBucketUseCase: updateBucketUseCase);
  });

  test("AddBucketEvent", () async {
    final bucket = bucketFixtures.first;
    final params = AddBucketUseCaseParams(bucket);

    when(getBucketsUseCase.call(any)).thenAnswer((_) async => Right(bucketFixtures));
    when(addBucketUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [InitialBucketsState(), BucketsAvailableState(bucketFixtures)];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = AddBucketEvent(bucket);
    bloc.dispatch(event);
  });

  test("AddReceiptToBucketEvent", () async {
    final receipt = receiptFixtures.first;
    final bucket = bucketFixtures.first;

    when(getBucketsUseCase.call(any)).thenAnswer((_) async => Right(bucketFixtures));

    final params = AddReceiptToBucketUseCaseParams(bucket.id, receipt.id);
    when(addReceiptToBucketUseCase.call(params));

    final expected = [InitialBucketsState(), BucketsAvailableState(bucketFixtures)];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = AddBucketEvent(bucket);
    bloc.dispatch(event);
  });

  test("GetBucketEvent", () async {
    final bucket = bucketFixtures.first;
    final params = GetBucketUseCaseParams(bucket.id);
    when(getBucketUseCase.call(params)).thenAnswer((_) async => Right(bucket));

    final expected = [InitialBucketsState(), BucketAvailableState(bucket)];

    expectLater(bloc.state, emitsInOrder(expected));

    final event = GetBucketEvent(bucket.id);
    bloc.dispatch(event);
  });

  test("GetBucketsEvent", () async {
    when(getBucketsUseCase.call(NoParams()))
        .thenAnswer((_) async => Right(bucketFixtures));

    final expected = [
      InitialBucketsState(),
      BucketsAvailableState(bucketFixtures)
    ];

    expectLater(bloc.state, emitsInOrder(expected));

    final event = GetBucketsEvent();
    bloc.dispatch(event);
  });

  test("RemoveBucketEvent", () async {
    final bucket = bucketFixtures.first;
    final params = RemoveBucketUseCaseParams(bucket.id);

    when(removeBucketUseCas.call(params))
        .thenAnswer((_) async => Right(EmptyData()));
    when(getBucketsUseCase.call(any)).thenAnswer((_) async => Right(bucketFixtures));

    final expected = [InitialBucketsState(), BucketsAvailableState(bucketFixtures)];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = RemoveBucketEvent(bucket.id);
    bloc.dispatch(event);
  });

  test("UpdateBucketEvent", () async {
    final bucket = bucketFixtures.first;
    final update = Bucket(bucket.id,
        name: "update", description: "update", receiptsIDs: []);

    final params = UpdateBucketUseCaseParams(update.id,
        receiptIDs: update.receiptsIDs,
        description: update.description,
        name: update.name);

    when(updateBucketUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));
    when(getBucketsUseCase.call(any)).thenAnswer((_) async => Right(bucketFixtures));

    final expected = [InitialBucketsState(), BucketsAvailableState(bucketFixtures)];
    expectLater(bloc.state, emitsInOrder(expected));

    final event = UpdateBucketEvent(update.id,
        name: update.name,
        description: update.description,
        receiptIDs: update.receiptsIDs);

    bloc.dispatch(event);
  });
}
