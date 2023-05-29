import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final passwordController = TextEditingController();
  AuthMode authMode = AuthMode.signup;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _submit() {}

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: deviceSize.width * .75,
        height: 320,
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              CupertinoTextFormFieldRow(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                placeholder: 'E-mail',
                onChanged: (value) => _authData['email'] = value,
                validator: (value) {
                  final email = value ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Invalid e-mail address';
                  }
                  return null;
                },
              ),
              CupertinoTextFormFieldRow(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                placeholder: 'Password',
                obscureText: true,
                onChanged: (value) => _authData['password'] = value,
                validator: (value) {
                  final password = value ?? '';
                  if (password.isEmpty ||
                      password.length < 5 ||
                      password.length > 16) {
                    return 'Password must have 6-16 characters';
                  }
                  return null;
                },
              ),
              if (authMode == AuthMode.signup)
                CupertinoTextFormFieldRow(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  placeholder: 'Confirm password',
                  obscureText: true,
                  validator: authMode == AuthMode.login
                      ? null
                      : (value) {
                          final password = value ?? '';
                          if (password != passwordController.text) {
                            return 'Passwords don\'t match';
                          }

                          return null;
                        },
                ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: _submit,
                borderRadius: BorderRadius.circular(30),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 30,
                ),
                child: Text(authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
