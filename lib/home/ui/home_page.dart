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
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<HomeState>(
          initialData: presenter.currentHomeState,
          stream: presenter.homeStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data ?? presenter.currentHomeState;
            switch (state.runtimeType) {
              case HomeStateEnterForm:
                final formState = state as HomeStateEnterForm;

                final emailError =
                    formState.emailError != ValidationError.noError ? formState.emailError?.description : null;
                final passwordError =
                    formState.passwordError != ValidationError.noError ? formState.passwordError?.description : null;

                return FormWidget(
                  emailError: emailError,
                  validateEmail: (email) => presenter.emmitEvent(
                    HomeValidateForm(fieldName: 'email', value: email),
                  ),
                  passwordError: passwordError,
                  validatePassword: (password) => presenter.emmitEvent(
                    HomeValidateForm(fieldName: 'password', value: password),
                  ),
                );
              case HomeStateLoading:
                return const LoadingWidget();
            }
            return const Center(
              child: Text('Empty State'),
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
  const FormWidget({
    Key? key,
    this.emailError,
    this.passwordError,
    this.validateEmail,
    this.validatePassword,
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
    }
  }
}
