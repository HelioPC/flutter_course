import 'package:chat_app/model/auth_form_data.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<void> _submit(AuthFormData data) async {
    try {
      if (data.isLogin) {
        await AuthService().login(data.email, data.password);
      } else {
        await AuthService().signup(
          data.email,
          data.password,
          data.name,
          data.image,
        );
      }

      debugPrint(data.toString());
    } catch (error) {
      debugPrint('');
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(
                onSubmit: _submit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
