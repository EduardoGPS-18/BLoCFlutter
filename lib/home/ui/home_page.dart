import 'package:flutter/material.dart';

import 'package:bloc_test/home/home.dart';

abstract class HomeEvent {}

class HomePage extends StatelessWidget {
  final HomePresenter presenter;
  const HomePage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: StreamBuilder<HomeState>(
          initialData: presenter.currentHomeState,
          stream: presenter.homeStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data ?? presenter.currentHomeState;
            switch (state.runtimeType) {
              case HomeStateEnterForm:
                final formState = state as HomeStateEnterForm;

                final hasEmailError = formState.emailError != ValidationError.noError;
                final showEmailInputBorder = formState.emailError != ValidationError.requiredFieldWithoutBorder;
                final showEmailError = hasEmailError && showEmailInputBorder;
                final emailError = showEmailError ? formState.emailError.description : null;

                final hasPasswordError = formState.passwordError != ValidationError.noError;
                final showPassInputBorder = formState.passwordError != ValidationError.requiredFieldWithoutBorder;
                final showPasswordError = hasPasswordError && showPassInputBorder;
                final passwordError = showPasswordError ? formState.passwordError.description : null;

                void submitFunction() => presenter.emmitEvent(HomeEventSubmit());

                return FormWidget(
                  emailError: emailError,
                  validateEmail: (email) => presenter.emmitEvent(
                    HomeValidateForm(fieldName: 'email', value: email),
                  ),
                  passwordError: passwordError,
                  validatePassword: (password) => presenter.emmitEvent(
                    HomeValidateForm(fieldName: 'password', value: password),
                  ),
                  onSubmit: (formState.isFormValid == true) ? submitFunction : null,
                );

              case HomeStateLoading:
                return const LoadingWidget();
            }
            return const Center(
              child: Text('Ocorreu um erro ao carregar o estado!'),
            );
          },
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  final String? emailError;
  final void Function(String)? validateEmail;
  final String? passwordError;
  final void Function(String)? validatePassword;
  final void Function()? onSubmit;

  const FormWidget({
    Key? key,
    this.emailError,
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
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

extension on ValidationError {
  String get description {
    switch (this) {
      case ValidationError.noError:
        return 'Sem erro!';
      case ValidationError.invalidField:
        return 'Campo inválido!';
      case ValidationError.requiredField:
        return 'Campo obrigatório';
      case ValidationError.requiredFieldWithoutBorder:
        return 'Campo obrigatório sem error!';
    }
  }
}
