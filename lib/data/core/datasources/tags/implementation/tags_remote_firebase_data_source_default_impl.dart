import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/data/core/datasources/tags/tags_remote_firebase_data_source.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TagsRemoteFirebaseDataSourceDefaultImpl implements TagsRemoteFirebaseDataSource, FirestoreDataSource {

  final Firestore firestore;
  String userID;

  List<Tag> tags;

  TagsRemoteFirebaseDataSourceDefaultImpl(this.firestore, this.userID);

  @override
  Future<void> addType(Tag type) async {
    await baseCollection.document(type.id).setData(type.toJson());
    tags = null;
  }

  @override
  CollectionReference get baseCollection => firestore.collection("tags").document(userID).collection("user_tags");

  @override
  Future<List<Tag>> getTypes() async {
    if(tags == null){
      await _loadTags();
    }

    return tags;
  }

  Future _loadTags() async {
    final snapshot = await baseCollection.getDocuments();
    tags = snapshot.documents.map((ds) => Tag.fromJson(ds.data)).toList();
  }

  @override
  Future<void> removeType(String id) async {
    await baseCollection.document(id).delete();
    tags = null;
  }

  @override
  Future<void> updateType(String id, Tag update) async {
    await baseCollection.document(id).setData(update.toJson());
    tags = null;
  }

  @override
  void clear() {
    tags = null;
  }

}