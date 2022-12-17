import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_v2/repositories/categories.repository.dart';
import 'package:flutter_firebase_v2/shared/loading.dart';

import 'list_items.dart';

class CategoryListPage extends StatelessWidget {
  static const String routeName = "/categories-list";

  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryRepository = CategoryRepository();

    return StreamBuilder<QuerySnapshot>(
      stream: categoryRepository.getAllCategoriesByUID(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            return CategoriesListItems(
              categories: snapshot.data!.docs,
            );
          case ConnectionState.waiting:
            return const CircularLoading();
          default:
            return Container();
        }
      },
    );
  }
}
