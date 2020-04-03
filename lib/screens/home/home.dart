import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/categories/list.dart';
import 'package:flutter_firebase/shared/master.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Hello!",
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: RaisedButton.icon(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  textColor: Colors.white,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => CategoriesScreen(),
                    //   ),
                    // );
                    Navigator.of(context).pushNamed(CategoriesScreen.routeName);
                  },
                  icon: Icon(
                    Icons.category,
                    color: Colors.white,
                  ),
                  label: Text("Categories"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
