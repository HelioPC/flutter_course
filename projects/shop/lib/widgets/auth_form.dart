import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  AuthMode authMode = AuthMode.signup;
  bool isLoading = false;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => isLoading = true);

    _formKey.currentState?.save();

    Auth auth = Provider.of<Auth>(context, listen: false);

    if (_isLogin()) {
      await auth.signIn(_authData['email']!, _authData['password']!);
    } else {
      await auth.signup(_authData['email']!, _authData['password']!);
    }

    setState(() => isLoading = false);
  }

  void _switchMode() {
    setState(() {
      if (_isLogin()) {
        authMode = AuthMode.signup;
      } else {
        authMode = AuthMode.login;
      }
    });
  }

  bool _isLogin() => authMode == AuthMode.login;
  bool _isSignup() => authMode == AuthMode.signup;

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
        height: 420,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CupertinoTextFormFieldRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
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
              if (_isSignup())
                CupertinoTextFormFieldRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  placeholder: 'Confirm password',
                  obscureText: true,
                  validator: _isLogin()
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
              Visibility(
                visible: !isLoading,
                replacement: const CircularProgressIndicator(),
                child: CupertinoButton.filled(
                  onPressed: _submit,
                  borderRadius: BorderRadius.circular(30),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 30,
                  ),
                  child: Text(authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
                ),
              ),
              const Spacer(),
              CupertinoButton(
                onPressed: _switchMode,
                child: Text(
                  _isLogin() ? 'SIGN UP NOW' : 'Have already an account?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
