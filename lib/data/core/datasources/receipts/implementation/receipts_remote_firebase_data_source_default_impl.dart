import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/data/core/datasources/receipts/receipts_remote_firebase_data_source.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptsRemoteFirebaseDataSourceDefaultImpl
    implements ReceiptsRemoteFirebaseDataSource, FirestoreDataSource {
  final Firestore firestore;
  final String userID;

  ReceiptsCollection _receiptsCollection =
      ReceiptsCollection(null, null, false);

  ReceiptsRemoteFirebaseDataSourceDefaultImpl(this.firestore, this.userID);

  @override
  Future<void> addType(Receipt type) async {
    final json = _firestoreJsonFromReceipt(type);
    await baseCollection.document(type.id).setData(json);
    _receiptsCollection.receipts = null;
  }

  @override
  Future<List<Receipt>> getReceiptsInReceiptMonth(
      ReceiptMonth receiptMonth) async {
    if (_receiptsCollection == null ||
        _receiptsCollection.receipts == null ||
        (_receiptsCollection.receiptsMonth != receiptMonth)) {
      await _loadReceiptsFromReceiptMonth(receiptMonth);
    }

    return _receiptsCollection.receipts;
  }

  @override
  Future<List<Receipt>> getTypes() async {
    if (_receiptsCollection.usesReceiptsMonth ||
        _receiptsCollection.receipts == null) {
      await _loadReceipts();
    }

    return _receiptsCollection.receipts;
  }

  Future _loadReceipts() async {
    final snapshot = await baseCollection.getDocuments();
    _receiptsCollection.receipts =
        snapshot.documents.map((ds) => Receipt.fromJson(ds.data)).toList();
    _receiptsCollection.usesReceiptsMonth = false;
  }

  Future _loadReceiptsFromReceiptMonth(ReceiptMonth receiptMonth) async {
    final query = await baseCollection
        .where("creationMonth", isEqualTo: receiptMonth.monthAsInt)
        .where("creationYear", isEqualTo: receiptMonth.yearAsInt)
        .getDocuments();

    final receipts = query.documents.map((ds) {
      final map = ds.data;

      (map["fields"] as List).forEach((element) {
        final value = element["value"];
        if (value is Timestamp) {
          element["value"] = value.toDate();
        }
      });

      return Receipt.fromJson(map);
    }).toList();

    _receiptsCollection.receipts = receipts;
    _receiptsCollection.receiptsMonth = receiptMonth;
    _receiptsCollection.usesReceiptsMonth = true;
  }

  @override
  Future<void> removeType(String id) async {
    await baseCollection.document(id).delete();
    _receiptsCollection.receipts = null;
  }

  @override
  Future<void> updateType(String id, Receipt update) async {
    final json = _firestoreJsonFromReceipt(update);
    await baseCollection.document(id).setData(json);
    _receiptsCollection.receipts = null;
  }

  @override
  CollectionReference get baseCollection => firestore
      .collection("receipts")
      .document(userID)
      .collection("user_receipts");

  Map<String, dynamic> _firestoreJsonFromReceipt(Receipt receipt) {
    final receiptJson = receipt.toJson();
    receiptJson["creationMonth"] = receipt.creationDate.month;
    receiptJson["creationYear"] = receipt.creationDate.year;

    return receiptJson;
  }
}

class ReceiptsCollection {
  ReceiptMonth receiptsMonth;
  List<Receipt> receipts;
  bool usesReceiptsMonth;

  ReceiptsCollection(this.receiptsMonth, this.receipts, this.usesReceiptsMonth);
}
