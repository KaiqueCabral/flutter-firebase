import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/category.model.dart';
import 'package:flutter_firebase/models/user.model.dart';
import 'package:flutter_firebase/repositories/category.repository.dart';
import 'package:flutter_firebase/shared/decorations.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:flutter_firebase/shared/master.dart';
import 'package:provider/provider.dart';

class CategoryAddUpdate extends StatefulWidget {
  final CategoryModel category;
  CategoryAddUpdate({this.category});
  @override
  _CategoryAddUpdateState createState() => _CategoryAddUpdateState();
}

class _CategoryAddUpdateState extends State<CategoryAddUpdate> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.category != null;
    final user = Provider.of<UserModel>(context);
    final _categoryDatabase = new CategoryRepository(uid: user.uid);

    return MasterScreen(
      title: "${isUpdate ? "Update" : "Add"} Category",
      body: isLoading
          ? Loading()
          : Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: isUpdate ? widget.category.name : "",
                    keyboardType: TextInputType.text,
                    decoration: textInputDecoration.copyWith(labelText: "Name"),
                    validator: (val) => val.isEmpty ? "Name is required" : null,
                    onSaved: (val) => _name = val,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          setState(() => isLoading = true);

                          _formKey.currentState.save();

                          final _category = CategoryModel(
                            name: _name,
                            uid: user.uid,
                          );

                          if (isUpdate) {
                            await Future.delayed(Duration(seconds: 2));
                            await _categoryDatabase.updateCategory(
                                _category, widget.category.id);
                          } else {
                            await _categoryDatabase.addCategory(_category);
                          }
                        } catch (e) {
                          print(e.toString());
                        } finally {
                          setState(() => isLoading = false);
                        }

                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
