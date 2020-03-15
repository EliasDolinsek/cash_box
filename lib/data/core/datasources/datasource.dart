import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataSource<Type> {

  Future<List<Type>> getTypes();
  Future<void> addType(Type type);
  Future<void> removeType(String id);
  Future<void> updateType(String id, Type update);

}

abstract class FirestoreDataSource {

  CollectionReference get baseCollection;

}

abstract class ReceiptsDataSource implements DataSource<Receipt> {

  Future<List<Receipt>> getReceiptsInReceiptMonth(ReceiptMonth receiptMonth);

}