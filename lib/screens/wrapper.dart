import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.model.dart';
import 'package:flutter_firebase/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase/screens/home/home.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/loading.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Loading();
          case ConnectionState.active:
            return Authenticate();
          case ConnectionState.done:
            if (snapshot.data != null)
              return Home();
            else
              return Authenticate();
            break;
          default:
            return null;
        }
      },
    );
  }
}
