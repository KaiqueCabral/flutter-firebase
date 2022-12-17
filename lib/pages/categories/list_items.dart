import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_v2/shared/master_scaffold.dart';

import '../../models/categories.model.dart';
import 'add_update.dart';

class CategoriesListItems extends StatefulWidget {
  final List<QueryDocumentSnapshot<Object?>> categories;
  const CategoriesListItems({super.key, required this.categories});

  @override
  State<CategoriesListItems> createState() => _CategoriesListItemsState();
}

class _CategoriesListItemsState extends State<CategoriesListItems> {
  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      title: "Categories",
      body: ListView(
        children: widget.categories
            .map((DocumentSnapshot document) {
              var categoryTile = CategoryModel.fromJson(
                document.data()! as Map<String, dynamic>,
                document.id,
              );

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.blue[500],
                    ),
                    title: Text(categoryTile.name),
                    subtitle: Text(
                        categoryTile.id != null && categoryTile.id!.isNotEmpty
                            ? categoryTile.id.toString()
                            : "No ID"),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CategoriesAddUpdatePage(
                          category: categoryTile,
                        ),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          twoButtonsDialog(categoryTile, context);
                        },
                      ),
                    ),
                  ),
                ),
              );
            })
            .toList()
            .cast(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          CategoriesAddUpdatePage.routeName,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  twoButtonsDialog(CategoryModel category, BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: const Text("Are you sure you want to delete this item?"),
      content: Text(
        "This action cannot be undone.",
        style: TextStyle(
          color: Colors.red[200],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Yes"),
          onPressed: () {
            //_repository.deleteCategory(category.id!);
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
