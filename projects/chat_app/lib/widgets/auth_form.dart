import 'package:chat_app/model/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:validatorless/validatorless.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function(AuthFormData) onSubmit;

  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();
  bool _isLoading = false;

  void _submit() async {
    setState(() => _isLoading = true);

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    await widget.onSubmit(_formData);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (!_formData.isLogin)
                TextFormField(
                  enabled: !_isLoading,
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.newName = name,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    final name = value ?? '';

                    if (name.isEmpty) return 'Required field';

                    return name.trim().length < 5
                        ? 'Minimum 5 characters'
                        : null;
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
              TextFormField(
                enabled: !_isLoading,
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.newEmail = email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Required field'),
                  Validatorless.email('Invalid email'),
                ]),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),
              TextFormField(
                enabled: !_isLoading,
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.newPassword = password,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                validator: (value) {
                  final password = value ?? '';

                  if (password.isEmpty) return 'Required field';

                  return password.trim().length < 5
                      ? 'Minimum 5 characters'
                      : null;
                },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: !_isLoading,
                replacement: LoadingAnimationWidget.threeArchedCircle(
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_formData.isLogin ? 'Entrar' : 'Submeter'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _formData.toggleMode();
                        });
                      },
                      child: Text(
                        _formData.isLogin
                            ? 'Criar uma nova conta'
                            : 'Já possui uma conta?',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
