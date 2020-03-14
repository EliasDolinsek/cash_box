import 'package:cash_box/data/core/datasources/fields/implementation/fields_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/receipts/implementation/receipts_local_mobile_data_source_moor_impl.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';

import '../../../../fixtures/field_fixtures.dart';
import '../../../../fixtures/receipts_fixtures.dart';

void main() {
  MoorAppDatabase database;
  FieldsLocalMobileDataSourceMoorImpl fieldsDataSource;
  ReceiptsLocalMobileDataSource dataSource;

  setUp(() {
    database = MoorAppDatabase(VmDatabase.memory(logStatements: true));
    fieldsDataSource = FieldsLocalMobileDataSourceMoorImpl(database);
    dataSource =
        ReceiptsLocalMobileDataSourceMoorImpl(database, fieldsDataSource);
  });

  test("addType and getTypes", () async {
    final receipt = receiptFixtures.first;
    await dataSource.addType(receipt);

    final result = await dataSource.getTypes();
    expect(result.first, receipt);
  });

  test("removeType", () async {
    final receipt = receiptFixtures.first;
    await dataSource.addType(receipt);

    await dataSource.removeType(receipt.id);

    final result = await dataSource.getTypes();
    expect(result.length, 0);
  });

  test("updateType", () async {
    final receipt = receiptFixtures.first;
    await dataSource.addType(receipt);

    final update = Receipt(
      receipt.id,
      type: ReceiptType.bank_statement,
      creationDate: DateTime.now(),
      fields: fieldFixtures,
      tagIDs: ["abc-123"],
    );

    await dataSource.updateType(receipt.id, update);

    final result = await dataSource.getTypes();
    expect(result.first, update);
  });
}
