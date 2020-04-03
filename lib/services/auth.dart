import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create User Object base on FirebaseUser
  UserModel _userFromFirebaseUser(FirebaseUser user) {
    return (user != null)
        ? UserModel(
            uid: user.uid,
            name: user.displayName,
            email: user.email,
          )
        : null;
  }

  //Auth Change User Stream
  Stream<UserModel> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //Get User using Shared Preferences
  Future<UserModel> getUser() async {
    var preferences = await SharedPreferences.getInstance();
    var data = preferences.getString("user");

    if (data != null) {
      return UserModel.fromMap(jsonDecode(data));
    }

    return null;
  }

  //Sign In Anonymous
  Future<UserModel> signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously();

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In With Email & Password
  Future<UserModel> signInWithEmailPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var preferences = await SharedPreferences.getInstance();
      await preferences.setString(
        "user",
        jsonEncode(
          UserModel(
            uid: result.user.uid,
            email: result.user.email,
          ).toMap(),
        ),
      );

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register With Email & Password
  Future registerWithEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign Out
  Future signOut() async {
    try {
      var preferences = await SharedPreferences.getInstance();
      preferences.setString("user", null);
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
