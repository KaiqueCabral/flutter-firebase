import 'package:flutter/material.dart';
import 'package:flutter_firebase_v2/authenticate/register.dart';
import 'package:flutter_firebase_v2/services/auth.dart';
import 'package:flutter_firebase_v2/shared/master_scaffold.dart';

import '../home.dart';
import '../shared/decorations.dart';
import '../shared/validations.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = "/sign-in";
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    text: "kaiquecabral@gmail.com",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "123123",
  );
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        backgroundColor: Colors.blue[400],
        elevation: 0,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RegisterPage.routeName,
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: textInputDecoration.copyWith(labelText: "E-mail"),
                validator: (val) => val == null || !validateEmail(val)
                    ? "Enter valid e-mail"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                decoration: textInputDecoration.copyWith(labelText: "Password"),
                obscureText: true,
                validator: (val) => val!.length < 6
                    ? "Enter a password with at least 6 caracteres."
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final navigator = Navigator.of(context);

                    var result = await _authService.signIn(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (result.isFailure) {
                      //Show error
                      return;
                    }

                    navigator.pushNamedAndRemoveUntil(
                      HomePage.routeName,
                      (route) => false,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
