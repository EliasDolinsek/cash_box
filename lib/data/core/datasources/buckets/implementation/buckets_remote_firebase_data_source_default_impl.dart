import 'package:cash_box/data/core/datasources/buckets/buckets_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BucketsRemoteFirebaseDataSourceDefaultImpl
    implements BucketsRemoteFirebaseDataSource, FirestoreDataSource {

  final Firestore firestore;
  final String userID;

  List<Bucket> buckets;

  BucketsRemoteFirebaseDataSourceDefaultImpl(this.firestore, this.userID);

  @override
  Future<void> addType(Bucket type) async {
    await baseCollection.add(type.toJson());
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
    final query =
        await baseCollection.where("id", isEqualTo: id).getDocuments();
    query.documents.forEach((ds) {
      ds.reference.delete();
    });
  }

  @override
  Future<void> updateType(String id, Bucket update) async {
    final query =
        await baseCollection.where("id", isEqualTo: id).getDocuments();
    query.documents.forEach((ds) {
      ds.reference.updateData(update.toJson());
    });
  }

  @override
  CollectionReference get baseCollection => firestore
      .collection("buckets")
      .document("user_id")
      .collection("user_buckets");
}
