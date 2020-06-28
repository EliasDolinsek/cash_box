import 'dart:convert';

import 'package:cash_box/data/core/datasources/fields/fields_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_local_mobile_data_source.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';

class ReceiptsLocalMobileDataSourceMoorImpl
    implements ReceiptsLocalMobileDataSource {
  final MoorAppDatabase database;
  final FieldsLocalMobileDataSource fieldsDataSource;

  ReceiptsLocalMobileDataSourceMoorImpl(this.database, this.fieldsDataSource);

  @override
  Future<void> addType(Receipt type) async {
    final receiptsMoorData = receiptsMoorDataFromReceipt(type);
    await fieldsDataSource.addAllFields(type.fields);
    return database.addReceipt(receiptsMoorData);
  }

  @override
  Future<List<Receipt>> getTypes() async {
    final receiptsMoorDataAsList = await database.getAllReceipts();
    return _receiptsFromReceiptsMoorDataList(receiptsMoorDataAsList);
  }

  @override
  Future<void> removeType(String id) async {
    final original = await database.getReceipt(id);
    final fieldIDs = json.decode(original.fieldIDs).cast<String>();

    await fieldsDataSource.removeAllFieldsWithIDs(fieldIDs);
    await database.deleteReceipt(id);
  }

  @override
  Future<void> updateType(String id, Receipt type) async {
    final originalReceipt = await _getReceiptByID(id);
    final fieldIDsAsList = originalReceipt.fields.map((e) => e.id).toList();
    await fieldsDataSource.removeAllFieldsWithIDs(fieldIDsAsList);

    final update = Receipt(
      id,
      type: type.type,
      creationDate: type.creationDate,
      fields: type.fields,
      tagIDs: type.tagIDs,
    );

    await fieldsDataSource.addAllFields(update.fields);

    await database.updateReceipt(receiptsMoorDataFromReceipt(update));
  }

  Future<Receipt> _getReceiptByID(String id) async {
    final receiptsMoorData = await database.getReceipt(id);
    final fieldsIDsAsList =
        json.decode(receiptsMoorData.fieldIDs).cast<String>();

    final fields = await fieldsDataSource.getFieldsWithIDs(fieldsIDsAsList);
    return receiptFromReceiptsMoorData(receiptsMoorData, fields);
  }

  @override
  Future<List<Receipt>> getReceiptsInReceiptMonth(ReceiptMonth receiptMonth) async {
    final receiptsMoorDataAsList = await database.getReceiptsInReceiptMonth(receiptMonth);
    return _receiptsFromReceiptsMoorDataList(receiptsMoorDataAsList);
  }

  Future<List<Receipt>> _receiptsFromReceiptsMoorDataList(List<ReceiptsMoorData> receiptsMoorDataList) async {
    final receipts = <Receipt>[];
    for (ReceiptsMoorData data in receiptsMoorDataList) {
      final fieldIDs = json.decode(data.fieldIDs).cast<String>();
      final fields = await fieldsDataSource.getFieldsWithIDs(fieldIDs);
      receipts.add(receiptFromReceiptsMoorData(data, fields));
    }

    return receipts;
  }
}
