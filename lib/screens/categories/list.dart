import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/category.model.dart';
import 'package:flutter_firebase/models/user.model.dart';
import 'package:flutter_firebase/screens/categories/add_update.dart';
import 'package:flutter_firebase/repositories/category.repository.dart';
import 'package:flutter_firebase/screens/categories/list_item.dart';
import 'package:flutter_firebase/shared/master.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    final _repository = new CategoryRepository(uid: user.uid);
    return StreamProvider<List<CategoryModel>>.value(
      value: _repository.categories,
      child: MasterScreen(
        title: "Categories",
        body: CategoriesList(),
        fab: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CategoryAddUpdate(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<CategoryModel>>(context) ?? [];

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return CategoryTile(
          category: categories[index],
        );
      },
      itemCount: categories != null ? categories.length : 0,
    );
  }
}
