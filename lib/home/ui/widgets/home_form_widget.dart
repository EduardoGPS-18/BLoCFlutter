import 'package:flutter/material.dart';

class HomeFormWidget extends StatelessWidget {
  final String? emailError;
  final void Function(String)? validateEmail;
  final String? passwordError;
  final void Function(String)? validatePassword;
  final void Function()? onSubmit;
  final void Function()? backButton;

  const HomeFormWidget({
    Key? key,
    this.emailError,
    this.backButton,
    this.validateEmail,
    this.passwordError,
    this.validatePassword,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Digite o email',
              labelText: 'EMAIL',
              errorText: emailError,
            ),
            onChanged: validateEmail,
          ),
          const SizedBox(height: 24),
          TextField(
            onChanged: validatePassword,
            decoration: InputDecoration(
              hintText: 'Digite a senha',
              errorText: passwordError,
              labelText: 'PASSWORD',
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text('Entrar!'),
                ),
              ),
            ],
          ),
          TextButton(onPressed: backButton, child: const Text('Voltar')),
        ],
      ),
    );
  }
}
