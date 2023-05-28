import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, .5),
                  Color.fromRGBO(255, 188, 117, .9),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
