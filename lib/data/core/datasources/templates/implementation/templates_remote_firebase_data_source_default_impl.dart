import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/data/core/datasources/templates/templates_remote_firebase_data_source.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TemplatesRemoteFirebaseDataSourceDefaultImpl implements TemplatesRemoteFirebaseDataSource, FirestoreDataSource {

  final Firestore firestore;
  final String userID;

  List<Template> templates;

  TemplatesRemoteFirebaseDataSourceDefaultImpl(this.firestore, this.userID);

  @override
  Future<void> addType(Template type) async {
    await baseCollection.document(type.id).setData(type.toJson());
    templates = null;
  }

  @override
  CollectionReference get baseCollection => firestore.collection("templates").document(userID).collection("user_templates");

  @override
  Future<List<Template>> getTypes() async {
    if(templates == null){
      await _loadTemplates();
    }

    return templates;
  }

  Future _loadTemplates() async {
    final snapshot = await baseCollection.getDocuments();
    templates = snapshot.documents.map((ds) => Template.fromJson(ds.data)).toList();
  }

  @override
  Future<void> removeType(String id) async {
    await baseCollection.document(id).delete();
    templates = null;
  }

  @override
  Future<void> updateType(String id, Template update) async {
    print(update.toJson());
    await baseCollection.document(id).setData(update.toJson());
    templates = null;
  }

}