import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final String collection;
  Query reference;
  DatabaseService({this.collection, this.uid}) {
    reference = Firestore.instance.collection(collection).where(
          "uid",
          isEqualTo: uid,
        );
  }

  Future<DocumentReference> addDocument(Map data) {
    return reference.reference().add(data);
  }

  Future<QuerySnapshot> getDataCollection() {
    return reference.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return reference.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return reference.reference().document(id).get();
  }

  Future<void> updateDocument(Map data, String id) {
    return reference.reference().document(id).updateData(data);
  }

  Future<void> deleteDocument(String id) {
    return reference.reference().document(id).delete();
  }
}
