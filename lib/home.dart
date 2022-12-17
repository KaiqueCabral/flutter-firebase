import 'package:flutter/material.dart';
import 'package:flutter_firebase_v2/authenticate/sign_in.dart';
import 'package:flutter_firebase_v2/pages/categories/list.dart';
import 'package:flutter_firebase_v2/services/auth.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Home"),
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
      body: Center(
        child: TextButton.icon(
          icon: const Icon(
            Icons.category,
            color: Colors.white,
          ),
          label: const Text(
            "Categories",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              CategoryListPage.routeName,
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(50),
            backgroundColor: Colors.green,
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
