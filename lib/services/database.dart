import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final String collection;
  DatabaseService({this.collection});

  Future<Query> getInstance() async {
    var preferences = await SharedPreferences.getInstance();
    String userData = preferences.getString("user");
    UserModel user = UserModel.fromMap(jsonDecode(userData));

    if (user != null) {
      return Firestore.instance.collection(collection).where(
            "uid",
            isEqualTo: user.uid,
          );
    } else {
      return null;
    }
  }

  Future<DocumentReference> addDocument(Map data) async {
    return (await getInstance()).reference().add(data);
  }

  Future<QuerySnapshot> getDataCollection() async {
    return (await getInstance()).getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() async* {
    yield* (await getInstance()).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) async {
    return (await getInstance()).reference().document(id).get();
  }

  Future<void> updateDocument(Map data, String id) async {
    return (await getInstance()).reference().document(id).updateData(data);
  }

  Future<void> deleteDocument(String id) async {
    return (await getInstance()).reference().document(id).delete();
  }
}
