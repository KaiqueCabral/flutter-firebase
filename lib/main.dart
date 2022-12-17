import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_v2/authenticate/register.dart';
import 'package:flutter_firebase_v2/authenticate/sign_in.dart';
import 'package:flutter_firebase_v2/home.dart';
import 'package:flutter_firebase_v2/models/user.model.dart';
import 'package:flutter_firebase_v2/pages/categories/add_update.dart';
import 'package:flutter_firebase_v2/pages/categories/list.dart';
import 'package:flutter_firebase_v2/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      initialData: UserModel(uid: "", email: ""),
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
        home: FirebaseAuth.instance.currentUser != null
            ? const HomePage()
            : const SignInPage(),
        routes: <String, WidgetBuilder>{
          CategoriesAddUpdatePage.routeName: (context) =>
              const CategoriesAddUpdatePage(),
          CategoryListPage.routeName: (context) => const CategoryListPage(),
          HomePage.routeName: (context) => const HomePage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          SignInPage.routeName: (context) => const SignInPage(),
        },
      ),
    );
  }
}
