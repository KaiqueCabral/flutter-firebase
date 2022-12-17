import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_v2/shared/result.dart';

import '../models/categories.model.dart';

class CategoryRepository {
  var categories = FirebaseFirestore.instance.collection("Categories");

  CategoryRepository();

  Future<Result> addCategory(
    CategoryModel category,
  ) async {
    await categories.add(category.toJson());

    return Result(
      isSuccess: true,
      isFailure: false,
    );
  }

  Future<Result> updateCategory(
    CategoryModel category,
    String documentId,
  ) async {
    await categories.doc(documentId).set(category.toJson());

    return Result(
      isSuccess: true,
      isFailure: false,
    );
  }

  Stream<QuerySnapshot> getAllCategoriesByUID() {
    return categories
        .where(
          "uid",
          isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? "",
        )
        .snapshots();
  }
}
