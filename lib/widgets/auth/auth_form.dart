import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  bool _isLogin = true;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email address",
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "Please enter a valid email address.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return "Please enter at least 4 characters .";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return "Password must be at least 7 characters long.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    child: Text(_isLogin ? "Login" : "SignUp"),
                    onPressed: () {
                      _trySubmit();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? "Create  new account"
                        : "Login to existing account"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
