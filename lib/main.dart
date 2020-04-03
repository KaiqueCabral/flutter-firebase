import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.model.dart';
import 'package:flutter_firebase/screens/authenticate/sign_in.dart';
import 'package:flutter_firebase/screens/categories/list.dart';
import 'package:flutter_firebase/screens/home/home.dart';
import 'package:flutter_firebase/screens/wrapper.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter - Connecting Firebase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue[900],
          ),
        ),
        home: Wrapper(),
        routes: <String, WidgetBuilder>{
          CategoriesScreen.routeName: (BuildContext context) =>
              CategoriesScreen(),
          Home.routeName: (BuildContext context) => Home(),
          SignIn.routeName: (BuildContext context) => SignIn(),
        },
      ),
    );
  }
}
