import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/receipts/add_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipts_in_receipt_month_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_receipts_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/remove_receipt_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/update_receipt_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/field_fixtures.dart';
import '../../fixtures/receipts_fixtures.dart';

class MockAddReceiptUseCase extends Mock implements AddReceiptUseCase {}

class MockGetReceiptUseCase extends Mock implements GetReceiptUseCase {}

class MockGetReceiptsUseCase extends Mock implements GetReceiptsUseCase {}

class MockGetReceiptsInReceiptMonthUseCase extends Mock
    implements GetReceiptsInReceiptMonthUseCase {}

class MockUpdateReceiptUseCase extends Mock implements UpdateReceiptUseCase {}

class MockRemoveReceiptUseCase extends Mock implements RemoveReceiptUseCase {}

void main() {
  final MockAddReceiptUseCase addReceiptUseCase = MockAddReceiptUseCase();
  final MockGetReceiptUseCase getReceiptUseCase = MockGetReceiptUseCase();
  final MockGetReceiptsUseCase getReceiptsUseCase = MockGetReceiptsUseCase();
  final MockGetReceiptsInReceiptMonthUseCase getReceiptsInReceiptMonthUseCase =
      MockGetReceiptsInReceiptMonthUseCase();
  final MockUpdateReceiptUseCase updateReceiptUseCase =
      MockUpdateReceiptUseCase();
  final MockRemoveReceiptUseCase removeReceiptUseCase =
      MockRemoveReceiptUseCase();

  ReceiptsBloc bloc;

  setUp(() async {
    bloc = ReceiptsBloc(
        addReceiptUseCase: addReceiptUseCase,
        getReceiptUseCase: getReceiptUseCase,
        getReceiptsUseCase: getReceiptsUseCase,
        getReceiptsInReceiptMonthUseCase: getReceiptsInReceiptMonthUseCase,
        updateReceiptUseCase: updateReceiptUseCase,
        removeReceiptUseCase: removeReceiptUseCase);
  });

  test("AddReceiptEvent", () async {
    final receipt = receiptFixtures.first;
    final params = AddReceiptUseCaseParams(receipt);

    when(getReceiptsUseCase.call(any)).thenAnswer((_) async => Right(receiptFixtures));
    when(addReceiptUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expect = [InitialReceiptsState(), ReceiptsAvailableState(receiptFixtures)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = AddReceiptEvent(receipt);
    bloc.dispatch(event);
  });

  test("GetReceiptEvent", () async {
    final receipt = receiptFixtures.first;
    final params = GetReceiptUseCaseParams(receipt.id);

    when(getReceiptUseCase.call(params))
        .thenAnswer((_) async => Right(receipt));

    final expect = [InitialReceiptsState(), ReceiptAvailableState(receipt)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = GetReceiptEvent(receipt.id);
    bloc.dispatch(event);
  });

  test("GetReceiptsEvent", () async {
    when(getReceiptsUseCase.call(NoParams()))
        .thenAnswer((_) async => Right(receiptFixtures));

    final expect = [
      InitialReceiptsState(),
      ReceiptsAvailableState(receiptFixtures)
    ];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = GetReceiptsEvent();
    bloc.dispatch(event);
  });

  test("GetReceiptsInReceiptMonthEvent", () async {
    final receiptMonth = ReceiptMonth(DateTime.now());
    final params = GetReceiptsInReceiptMonthUseCaseParams(receiptMonth);
    when(getReceiptsInReceiptMonthUseCase.call(params))
        .thenAnswer((_) async => Right(receiptFixtures));

    final expect = [
      InitialReceiptsState(),
      ReceiptsInReceiptMonthAvailableState(receiptMonth, receiptFixtures)
    ];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = GetReceiptsInReceiptMonthEvent(receiptMonth);
    bloc.dispatch(event);
  });

  test("UpdateReceiptEvent", () async {
    final receipt = receiptFixtures.first;
    final update = Receipt(receipt.id,
        type: ReceiptType.income,
        creationDate: receipt.creationDate,
        fields: fieldFixtures,
        tagIDs: []);

    final params = UpdateReceiptUseCaseParams(update.id,
        tagIDs: update.tagIDs, fields: update.fields, type: update.type);

    when(getReceiptsUseCase.call(any)).thenAnswer((_) async => Right(receiptFixtures));

    when(updateReceiptUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expect = [InitialReceiptsState(), ReceiptsAvailableState(receiptFixtures)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = UpdateReceiptEvent(update.id,
        type: update.type, fields: update.fields, tagIDs: update.tagIDs);
    bloc.dispatch(event);
  });

  test("RemoveReceiptEvent", () async {
    final receipt = receiptFixtures.first;
    final params = RemoveReceiptUseCaseParams(receipt.id);

    when(getReceiptsUseCase.call(any)).thenAnswer((_) async => Right(receiptFixtures));

    when(removeReceiptUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expect = [InitialReceiptsState(), ReceiptsAvailableState(receiptFixtures)];

    expectLater(bloc.state, emitsInOrder(expect));

    final event = RemoveReceiptEvent(receipt.id);
    bloc.dispatch(event);
  });
}
