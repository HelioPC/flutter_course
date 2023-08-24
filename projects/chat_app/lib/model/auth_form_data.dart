import 'dart:io';

enum AuthMode { signUp, login }

class AuthFormData {
  String _name = '';
  String _email = '';
  String _password = '';
  File? _image;
  AuthMode _mode = AuthMode.login;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  File? get image => _image;
  bool get isLogin => _mode == AuthMode.login;

  set newName(String newName) {
    _name = newName;
  }

  set newEmail(String newEmail) {
    _email = newEmail;
  }

  set newPassword(String newPassword) {
    _password = newPassword;
  }

  set newImage(File newImage) {
    _image = newImage;
  }

  void toggleMode() => _mode = isLogin ? AuthMode.signUp : AuthMode.login;

  @override
  String toString() {
    return '$_name | $_email | $_password | ${_image?.path ?? 'null'}';
  }
}
