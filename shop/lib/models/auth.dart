import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expirationDate;
  Timer? _timer;

  bool get isAuth {
    final isValid = _expirationDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

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

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];
      _expirationDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );

      _autoLogout();

      notifyListeners();
    }
  }

  Future<void> signup(String email, String password) async {
    return await _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return await _authenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = null;
    _email = null;
    _expirationDate = null;
    _uid = null;
    _clearAutoLogout();
    notifyListeners();
  }

  void _clearAutoLogout() {
    _timer?.cancel();
    _timer = null;
  }

  void _autoLogout() {
    _clearAutoLogout();
    final seconds = _expirationDate?.difference(DateTime.now()).inSeconds;
    _timer = Timer(Duration(seconds: seconds ?? 0), logout);
  }
}
