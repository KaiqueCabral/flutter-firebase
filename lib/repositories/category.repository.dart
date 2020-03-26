import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/category.model.dart';
import 'package:flutter_firebase/services/database.dart';

class CategoryRepository {
  final String uid;
  DatabaseService _api;
  CategoryRepository({this.uid}) {
    _api = DatabaseService(
      collection: "Categories",
      uid: uid,
    );
  }

  Future<void> addCategory(CategoryModel category) async {
    await _api.addDocument(category.toJson());
  }

  List<CategoryModel> getCategoryModel(QuerySnapshot snapshot) {
    return snapshot.documents
        .map(
          (category) => CategoryModel.fromJson(
            category.data,
            category.documentID,
          ),
        )
        .toList();
  }

  Future<CategoryModel> getCategoryById(String id) async {
    DocumentSnapshot doc = await _api.getDocumentById(id);
    return CategoryModel.fromJson(doc.data, doc.documentID);
  }

  Future<void> updateCategory(CategoryModel category, String documentID) async {
    await _api.updateDocument(category.toJson(), documentID);
  }

  Future<void> deleteCategory(String documentID) async {
    await _api.deleteDocument(documentID);
  }

  //get cateogires Stream
  Stream<List<CategoryModel>> get categories {
    return _api.streamDataCollection().map(getCategoryModel);
  }
}
