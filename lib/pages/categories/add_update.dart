import 'package:flutter/material.dart';
import 'package:flutter_firebase_v2/shared/loading.dart';
import 'package:flutter_firebase_v2/shared/master_scaffold.dart';
import 'package:flutter_firebase_v2/shared/result.dart';
import 'package:provider/provider.dart';

import '../../models/categories.model.dart';
import '../../models/user.model.dart';
import '../../repositories/categories.repository.dart';
import '../../shared/decorations.dart';

class CategoriesAddUpdatePage extends StatefulWidget {
  static const String routeName = "/categories-add-update";

  final CategoryModel? category;

  const CategoriesAddUpdatePage({super.key, this.category});

  @override
  State<CategoriesAddUpdatePage> createState() =>
      _CategoriesAddUpdatePageState();
}

class _CategoriesAddUpdatePageState extends State<CategoriesAddUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.category != null;
    final user = Provider.of<UserModel>(context);
    final repository = CategoryRepository();
    final TextEditingController nameController = TextEditingController(
      text: isUpdate ? widget.category!.name : "",
    );

    return MasterScaffold(
      title: "Categories: Add/Updates",
      body: isLoading
          ? const CircularLoading()
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: <Widget>[
                  boxSpace(),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: textInputDecoration.copyWith(labelText: "Name"),
                    validator: (val) =>
                        val!.isEmpty ? "Name is required" : null,
                  ),
                  boxSpace(),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => isLoading = true);

                        Result result = await addOrUpdateCategory(
                            nameController, user, isUpdate, repository);

                        setState(() => isLoading = false);

                        if (result.isFailure) {
                          //Show error
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: const Text(
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

  Future<Result> addOrUpdateCategory(
      TextEditingController nameController,
      UserModel user,
      bool isUpdate,
      CategoryRepository categoryDatabase) async {
    try {
      final category = CategoryModel(
        name: nameController.text,
        uid: user.uid,
      );

      Result result;
      if (isUpdate) {
        result = await categoryDatabase.updateCategory(
          category,
          widget.category!.id!,
        );
      } else {
        result = await categoryDatabase.addCategory(category);
      }

      return result;
    } catch (e) {
      return Result(
        isSuccess: false,
        isFailure: true,
        error: e.toString(),
      );
    }
  }

  SizedBox boxSpace() {
    return const SizedBox(
      height: 20,
    );
  }
}
