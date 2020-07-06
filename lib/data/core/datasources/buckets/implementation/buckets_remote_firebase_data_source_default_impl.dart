import 'package:cash_box/data/core/datasources/buckets/buckets_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BucketsRemoteFirebaseDataSourceDefaultImpl
    implements BucketsRemoteFirebaseDataSource, FirestoreDataSource {

  final Firestore firestore;
  String userID;

  List<Bucket> buckets;

  BucketsRemoteFirebaseDataSourceDefaultImpl(this.firestore, this.userID);

  @override
  Future<void> addType(Bucket type) async {
    buckets = null;
    await baseCollection.document(type.id).setData(type.toJson());
  }

  @override
  Future<List<Bucket>> getTypes() async {
    if (buckets == null) {
      await _loadBuckets();
    }

    return buckets;
  }

  Future _loadBuckets() async {
    final snapshot = await baseCollection.getDocuments();
    buckets = snapshot.documents.map((ds) => Bucket.fromJson(ds.data)).toList();
  }

  @override
  Future<void> removeType(String id) async {
    await baseCollection.document(id).delete();
    buckets = null;
  }

  @override
  Future<void> updateType(String id, Bucket update) async {
    await baseCollection.document(id).setData(update.toJson());
    buckets = null;
  }

  @override
  CollectionReference get baseCollection => firestore
      .collection("buckets")
      .document(userID)
      .collection("user_buckets");

  @override
  void clear() {
    buckets = null;
  }
}
