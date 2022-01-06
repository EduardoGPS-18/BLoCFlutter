import 'presenter.dart';

abstract class HomeState {}

class HomeStateLoading implements HomeState {}

class HomeStateEnterForm implements HomeState {
  final String email;
  final ValidationError emailError;
  final String password;
  final ValidationError passwordError;
  final bool isFormValid;

  HomeStateEnterForm({
    required this.email,
    required this.password,
    required this.emailError,
    required this.passwordError,
    required this.isFormValid,
  });

  HomeStateEnterForm copyWith({
    String? email,
    ValidationError? emailError,
    String? password,
    ValidationError? passwordError,
    bool? isFormValid,
  }) {
    return HomeStateEnterForm(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
