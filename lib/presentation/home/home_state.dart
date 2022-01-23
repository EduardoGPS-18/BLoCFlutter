import 'package:bloc_test/presentation/validations/validation.dart';

abstract class HomeState {}

class HomeStateLoading implements HomeState {}

enum ProccessLoading { none, start, end }
enum ProccessResult { success, error, close, none }

extension IsOpen on ProccessResult {
  bool get isOpen => this == ProccessResult.success || this == ProccessResult.error ? true : false;
}

class HomeStateEnterForm implements HomeState {
  final String email;
  final ValidationError emailError;
  final String password;
  final ValidationError passwordError;
  final bool isFormValid;
  final ProccessLoading proccessLoading;
  final ProccessResult proccessResult;

  // Close page has no own state because is expected that background stay in form enter state on transition
  final bool closePage;

  HomeStateEnterForm({
    required this.email,
    required this.password,
    required this.emailError,
    required this.passwordError,
    required this.isFormValid,
    this.closePage = false,
    this.proccessLoading = ProccessLoading.none,
    this.proccessResult = ProccessResult.none,
  });

  HomeStateEnterForm copyWith({
    String? email,
    ValidationError? emailError,
    String? password,
    ValidationError? passwordError,
    bool? isFormValid,
    bool? closePage = false,
    ProccessLoading proccessLoading = ProccessLoading.none,
    ProccessResult proccessResult = ProccessResult.none,
  }) {
    return HomeStateEnterForm(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
      closePage: closePage ?? this.closePage,
      proccessLoading: proccessLoading,
      proccessResult: proccessResult,
    );
  }
}
