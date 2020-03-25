import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';

class MasterScreen extends StatefulWidget {
  final String title;
  final Widget body;
  final AppBar appBar;
  final FloatingActionButton fab;
  MasterScreen({this.title, this.body, this.appBar, this.fab});

  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: widget.appBar != null
          ? widget.appBar
          : AppBar(
              title: Text(widget != null ? widget.title : ""),
              backgroundColor: Colors.blue[400],
              elevation: 0,
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue[50],
                  ),
                  label: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.blue[50],
                    ),
                  ),
                ),
              ],
            ),
      body: widget.body != null ? widget.body : Container(),
      floatingActionButton: widget.fab != null ? widget.fab : null,
      //CategoriesList(),
    );
  }
}
