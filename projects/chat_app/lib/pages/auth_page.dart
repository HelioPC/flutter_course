import 'dart:developer';

import 'package:chat_app/model/auth_form_data.dart';
import 'package:chat_app/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<void> _submit(AuthFormData data) async {
    await Future.delayed(const Duration(seconds: 5));
    log(data.toString());
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
