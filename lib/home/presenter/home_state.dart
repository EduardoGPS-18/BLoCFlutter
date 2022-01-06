import 'presenter.dart';

abstract class HomeState {}

class HomeStateLoading implements HomeState {}

class HomeStateEnterForm implements HomeState {
  final ValidationError? emailError;
  final ValidationError? passwordError;

  HomeStateEnterForm({this.emailError, this.passwordError});

  HomeStateEnterForm copyWith(HomeStateEnterForm newState) => HomeStateEnterForm(
        emailError: newState.emailError ?? emailError,
        passwordError: newState.passwordError ?? passwordError,
      );
}
