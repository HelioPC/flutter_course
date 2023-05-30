import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> _authenticate(String email, String password, String type) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$type?key='
        'AIzaSyDIelHFH8w-tVsxo3muJQEYiV9wvuh-JQU';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(response.body);
  }

  Future<void> signup(String email, String password) async {
    await _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    await _authenticate(email, password, 'signInWithPassword');
  }
}
