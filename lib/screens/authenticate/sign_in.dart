import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/decorations.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:flutter_firebase/shared/validations.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email;
  String password;
  String error = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              title: Text("Sign In"),
              backgroundColor: Colors.blue[500],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: "",
                      decoration:
                          textInputDecoration.copyWith(labelText: "E-mail"),
                      validator: (val) => val.isEmpty || !validateEmail(val)
                          ? "Enter valid e-mail"
                          : null,
                      onSaved: (val) => email = val,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration:
                          textInputDecoration.copyWith(labelText: "Password"),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? "Enter a password with at least 6 caracteres."
                          : null,
                      onSaved: (val) => password = val,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.green[400],
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() => isLoading = true);
                          var result = await _auth.signInWithEmailPassword(
                              email, password);

                          if (result == null) {
                            setState(() {
                              error =
                                  "Could not sign in with those credentials.";
                            });
                          } else {
                            print(result);
                          }

                          setState(() => isLoading = false);
                        }
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
