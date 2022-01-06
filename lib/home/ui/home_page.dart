import 'package:flutter/material.dart';

import '/home/home.dart';
import './widgets/widgets.dart';

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

                return HomeFormWidget(
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

              default:
                return const Center(
                  child: Text('Ocorreu um erro ao carregar o estado!'),
                );
            }
          },
        ),
      ),
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
