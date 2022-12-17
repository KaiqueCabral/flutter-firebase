import 'package:flutter/material.dart';

import '../authenticate/sign_in.dart';
import '../services/auth.dart';

class MasterScaffold extends StatefulWidget {
  final String? title;
  final Widget? body;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;

  const MasterScaffold({
    super.key,
    this.title,
    this.body,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  State<MasterScaffold> createState() => _MasterScaffoldState();
}

class _MasterScaffoldState extends State<MasterScaffold> {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: widget.appBar ??
          AppBar(
            title: Text(widget.title ?? ""),
            backgroundColor: Colors.blue[400],
            elevation: 0,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  await authService.signOut();

                  navigator.pushNamedAndRemoveUntil(
                    SignInPage.routeName,
                    (route) => false,
                  );
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
      body: widget.body ?? Container(),
      floatingActionButton: widget.floatingActionButton,
      //CategoriesList(),
    );
  }
}
