import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/category.model.dart';
import 'package:flutter_firebase/screens/categories/add_update.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  CategoryTile({this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: ListTile(
          contentPadding: EdgeInsets.all(5),
          leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.blue[500],
          ),
          title: Text(category.name),
          //subtitle: Text(category.id),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CategoryAddUpdate(
                category: category,
              ),
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(Icons.edit),
              padding: EdgeInsets.all(0),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
