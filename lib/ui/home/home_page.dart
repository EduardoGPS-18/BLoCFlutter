import 'package:bloc_test/presentation/home/home.dart';
import 'package:bloc_test/presentation/validations/validation.dart';
import 'package:bloc_test/ui/ui.dart';
import 'package:flutter/material.dart';

import './widgets/widgets.dart';

class HomePage extends StatelessWidget {
  final HomePresenter presenter;
  const HomePage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SafeArea(
            child: StreamBuilder<HomeState>(
              initialData: presenter.currentHomeState,
              stream: presenter.homeStateStream,
              builder: (ctx, snapshot) {
                final state = snapshot.data ?? presenter.currentHomeState;

                if (state.runtimeType == HomeStateEnterForm) {
                  final formState = state as HomeStateEnterForm;

                  final hasEmailError = formState.emailError != ValidationError.noError;
                  final emailError = hasEmailError ? formState.emailError.description : null;

                  final hasPasswordError = formState.passwordError != ValidationError.noError;
                  final passwordError = hasPasswordError ? formState.passwordError.description : null;

                  void submitFunction() => presenter.emmitEvent(HomeEventSubmit());

                  if (state.closePage) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    });
                  }

                  if (state.proccessResult == ProccessResult.success) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: Colors.green[200],
                          title: const Text('SUCESSO!!!!!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                presenter.emmitEvent(HomeEventCloseProccess());
                              },
                              child: const Text('OK!'),
                            ),
                            TextButton(
                              onPressed: () {
                                presenter.emmitEvent(HomeEventClosePage());
                              },
                              child: const Text('SAIR!'),
                            ),
                          ],
                          content: const Text('Processo finalizado com sucesso!!'),
                        ),
                      );
                    });
                  } else if (state.proccessResult == ProccessResult.error) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AlertDialog(
                          title: const Text('Error!!!!!!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                presenter.emmitEvent(HomeEventCloseProccess());
                              },
                              child: const Text('OK!'),
                            ),
                            TextButton(
                              onPressed: () {
                                presenter.emmitEvent(HomeEventClosePage());
                              },
                              child: const Text('SAIR!'),
                            ),
                          ],
                          backgroundColor: Colors.red[200],
                          content: const Text('Ocorreu um erro no processo!!!'),
                        ),
                      );
                    });
                  } else if (state.proccessResult == ProccessResult.close) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      Navigator.pop(context);
                    });
                  }

                  if (state.proccessLoading == ProccessLoading.start) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => const AlertDialog(
                          title: Text('Loading...'),
                          content: Text('Aguarde!'),
                        ),
                      );
                    });
                  } else if (state.proccessLoading == ProccessLoading.end) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }

                  return HomeFormWidget(
                    emailError: emailError,
                    validateEmail: (email) => presenter.emmitEvent(
                      HomeValidateEmail(fieldName: 'email', value: email),
                    ),
                    passwordError: passwordError,
                    validatePassword: (password) => presenter.emmitEvent(
                      HomeValidatePassword(fieldName: 'password', value: password),
                    ),
                    onSubmit: (formState.isFormValid == true) ? submitFunction : null,
                    backButton: () {
                      presenter.emmitEvent(HomeEventClosePage());
                    },
                  );
                }

                return const Center();
              },
            ),
          ),
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
      case ValidationError.fieldsDoNotMatch:
        return 'Campos diferentes';
      case ValidationError.minLength:
        return 'Tamanho minimo não atingido';
    }
  }
}
