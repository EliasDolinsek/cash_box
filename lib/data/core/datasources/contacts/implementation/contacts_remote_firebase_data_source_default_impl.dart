import 'package:cash_box/data/core/datasources/contacts/contacts_remote_firebase_data_source.dart';
import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsRemoteFirebaseDataSourceDefaultImpl implements ContactsRemoteFirebaseDataSource, FirestoreDataSource {

  final Firestore firestore;
  String userID;

  List<Contact> contacts;

  ContactsRemoteFirebaseDataSourceDefaultImpl(this.firestore, this.userID);

  @override
  Future<void> addType(Contact type) async {
    await baseCollection.document(type.id).setData(type.toJson());
    contacts = null;
  }

  @override
  CollectionReference get baseCollection => firestore.collection("contacts").document(userID).collection("user_contacts");

  @override
  Future<List<Contact>> getTypes() async {
    if(contacts == null){
      await _loadContacts();
    }

    return contacts;
  }

  Future _loadContacts() async {
    final snapshot = await baseCollection.getDocuments();
    contacts = snapshot.documents.map((ds) {
      final map = ds.data;

      (map["fields"] as List).forEach((element) {
        final value = element["value"];
        if(value is Timestamp){
          element["value"] = value.toDate();
        }
      });

      return Contact.fromJson(map);
    }).toList();
  }

  @override
  Future<void> removeType(String id) async {
    await baseCollection.document(id).delete();
    contacts = null;
  }

  @override
  Future<void> updateType(String id, Contact update) async {
    await baseCollection.document(id).setData(update.toJson());
    contacts = null;
  }

  @override
  void clear() {
    contacts = null;
  }

}