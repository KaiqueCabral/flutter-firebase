import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/category.model.dart';
import 'package:flutter_firebase/models/user.model.dart';
import 'package:flutter_firebase/repositories/category.repository.dart';
import 'package:flutter_firebase/screens/categories/add_update.dart';
import 'package:provider/provider.dart';

class CategoryTile extends StatefulWidget {
  final CategoryModel category;
  CategoryTile({this.category});

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final CategoryRepository _repository =
        new CategoryRepository(uid: user.uid);

    twoButtonsDialog(CategoryModel category) {
      AlertDialog _dialog = AlertDialog(
        title: Text("Are you sure you want to delete this item?"),
        content: Text(
          "This action cannot be undone.",
          style: TextStyle(
            color: Colors.red[200],
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text("Yes"),
            onPressed: () {
              _repository.deleteCategory(category.id);
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _dialog;
        },
      );
    }

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
          title: Text(widget.category.name),
          //subtitle: Text(category.id),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CategoryAddUpdate(
                category: widget.category,
              ),
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              padding: EdgeInsets.all(0),
              onPressed: () {
                twoButtonsDialog(widget.category);
              },
            ),
          ),
        ),
      ),
    );
  }
}
