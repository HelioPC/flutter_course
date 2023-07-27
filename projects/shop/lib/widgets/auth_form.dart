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
  AuthMode authMode = AuthMode.login;
  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;
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

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.linear),
    );

    _slideAnimation = Tween(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                enabled: !isLoading,
                decoration: const InputDecoration(hintText: 'E-mail'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _authData['email'] = value,
                validator: (value) {
                  final email = value ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Invalid e-mail address';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: !isLoading,
                decoration: const InputDecoration(hintText: 'Password'),
                controller: passwordController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
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
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ? 0 : 60,
                  maxHeight: _isLogin() ? 0 : 120,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
                      enabled: !isLoading,
                      decoration: const InputDecoration(
                        hintText: 'Confirm password',
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
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
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: !isLoading,
                replacement: const CircularProgressIndicator.adaptive(),
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
