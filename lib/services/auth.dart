import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.model.dart';
import '../shared/result.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User? user) {
    return UserModel(uid: user!.uid, email: user.email!);
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<Result> register(
      String name, String emailAddress, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      return Result(
        isSuccess: true,
        isFailure: false,
        data: credential,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          return Result(
            isSuccess: false,
            isFailure: true,
            error: 'The password provided is too weak.',
          );
        case "email-already-in-use":
          return Result(
            isSuccess: false,
            isFailure: true,
            error: 'The account already exists for that email.',
          );
        default:
          return Result(
            isSuccess: false,
            isFailure: true,
            error: 'An unexpected error occurred.',
          );
      }
    } catch (e) {
      return Result(
        isSuccess: false,
        isFailure: true,
        error: 'An unexpected error occurred.',
      );
    }
  }

  Future<Result> signIn(String emailAddress, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return Result(
        isSuccess: true,
        isFailure: false,
        data: credential,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
        case "wrong-password":
          return Result(
            isSuccess: false,
            isFailure: true,
            error: "Email and password do not match.",
          );
        default:
          return Result(
            isSuccess: false,
            isFailure: true,
            error: "An unexpected error occurred.",
          );
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
