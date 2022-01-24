import 'package:bloc_test/presentation/home/home.dart';
import 'package:bloc_test/presentation/validations/validation.dart';
import 'package:bloc_test/ui/ui.dart';
import 'package:flutter/material.dart';

import './widgets/widgets.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;
  const HomePage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.presenter.homeStateStream.listen((state) {
      if (state is HomeStateEnterForm) {
        if (state.proccessResult == ProccessResult.success) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(const SnackBar(
                content: Text('Authenticado com sucesso!'),
                backgroundColor: Colors.green,
              ));
          });
        } else if (state.proccessResult == ProccessResult.error) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(const SnackBar(
                content: Text('Ocorreu um erro!'),
                backgroundColor: Colors.red,
              ));
          });
        }
      }
    });
  }

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
              initialData: widget.presenter.currentHomeState,
              stream: widget.presenter.homeStateStream,
              builder: (ctx, snapshot) {
                final state = snapshot.data ?? widget.presenter.currentHomeState;

                if (state is HomeStateEnterForm) {
                  final hasEmailError = state.emailError != ValidationError.noError;
                  final emailError = hasEmailError ? state.emailError.description : null;

                  final hasPasswordError = state.passwordError != ValidationError.noError;
                  final passwordError = hasPasswordError ? state.passwordError.description : null;

                  void submitFunction() => widget.presenter.emmitEvent(HomeEventSubmit());

                  return HomeFormWidget(
                    emailError: emailError,
                    validateEmail: (email) => widget.presenter.emmitEvent(
                      HomeValidateEmail(fieldName: 'email', value: email),
                    ),
                    passwordError: passwordError,
                    validatePassword: (password) => widget.presenter.emmitEvent(
                      HomeValidatePassword(fieldName: 'password', value: password),
                    ),
                    onSubmit: (state.isFormValid == true) ? submitFunction : null,
                    backButton: () {
                      widget.presenter.emmitEvent(HomeEventClosePage());
                    },
                    isLoading: state.proccessLoading == ProccessLoading.loading,
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
