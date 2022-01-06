import 'presenter.dart';

abstract class HomeState {}

class HomeStateLoading implements HomeState {}

class HomeStateEnterForm implements HomeState {
  final ValidationError emailError;
  final ValidationError passwordError;
  final bool isFormValid;

  HomeStateEnterForm({required this.emailError, required this.passwordError, required this.isFormValid});

  HomeStateEnterForm copyWith({
    ValidationError? emailError,
    ValidationError? passwordError,
    bool? isFormValid,
  }) {
    return HomeStateEnterForm(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
