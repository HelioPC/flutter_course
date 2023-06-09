import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  AuthMode authMode = AuthMode.signup;
  AnimationController? _animationController;
  Animation<Size>? _heightAnimation;
  bool isLoading = false;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String msg) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Authentication failed'),
          content: Text(msg),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => isLoading = true);

    _formKey.currentState?.save();

    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.signIn(_authData['email']!, _authData['password']!);
      } else {
        await auth.signup(_authData['email']!, _authData['password']!);
      }
    } on AuthException catch (e) {
      _showErrorDialog(e.toString());
    } catch (e) {
      _showErrorDialog('Unexpected error');
    }

    setState(() => isLoading = false);
  }

  void _switchMode() {
    setState(() {
      if (_isLogin()) {
        authMode = AuthMode.signup;
        _animationController?.forward();
      } else {
        authMode = AuthMode.login;
        _animationController?.reverse();
      }
    });
  }

  bool _isLogin() => authMode == AuthMode.login;
  bool _isSignup() => authMode == AuthMode.signup;

  @override
  void dispose() {
    passwordController.dispose();
    _animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightAnimation = Tween(
      begin: const Size(double.infinity, 310),
      end: const Size(double.infinity, 400),
    ).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.linear),
    );

    _heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: _heightAnimation?.value.height ?? (_isLogin() ? 310 : 400),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CupertinoTextFormFieldRow(
                enabled: !isLoading,
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
                enabled: !isLoading,
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
                  enabled: !isLoading,
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
