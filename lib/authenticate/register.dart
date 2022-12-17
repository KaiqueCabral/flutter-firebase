import 'package:flutter/material.dart';
import 'package:flutter_firebase_v2/authenticate/sign_in.dart';
import 'package:flutter_firebase_v2/shared/master_scaffold.dart';

import '../services/auth.dart';
import '../shared/decorations.dart';
import '../shared/validations.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "/register";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.blue[400],
        elevation: 0,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                SignInPage.routeName,
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              "Sign In",
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
                controller: _nameController,
                decoration: textInputDecoration.copyWith(labelText: "Name"),
                validator: (val) => val!.length > 100
                    ? "Name must contain less than 100 characters"
                    : null,
              ),
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
                decoration: textInputDecoration.copyWith(
                  labelText: "Password",
                ),
                validator: (val) => val!.length < 6
                    ? "Enter a password with at least 6 caracteres."
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var result = await _authService.register(
                      _nameController.text,
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (result.isFailure) {
                      //Show error
                    }
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
