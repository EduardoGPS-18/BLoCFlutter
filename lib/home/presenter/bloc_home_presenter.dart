import 'package:bloc/bloc.dart';

import '../helpers/helpers.dart';
import '../ui/ui.dart';

import 'presenter.dart';

enum ValidationError {
  noError,
  invalidField,
  requiredField,
  requiredFieldWithoutBorder,
}

final _initialState = HomeStateEnterForm(
  emailError: ValidationError.requiredFieldWithoutBorder,
  passwordError: ValidationError.requiredFieldWithoutBorder,
  isFormValid: false,
);

class HomeBloc extends Bloc<HomeEvent, HomeState> with BlocPresenter implements HomePresenter {
  HomeBloc() : super(_initialState) {
    on<HomeValidateForm>(
      (event, emit) {
        emit(validateField(event.fieldName, event.value));
      },
    );

    on<HomeEventSubmit>(
      (event, emit) {
        emit(HomeStateLoading());
      },
    );
  }

  HomeStateEnterForm validateField(String fieldName, String? value) {
    final stateForm = state as HomeStateEnterForm;
    var newState = stateForm.copyWith();

    if (fieldName == 'email') {
      final emailError = value?.contains('@') == true ? ValidationError.noError : ValidationError.invalidField;
      newState = stateForm.copyWith(emailError: emailError);
    }
    if (fieldName == 'password') {
      final passwordError = (value?.length ?? 0) >= 10 ? ValidationError.noError : ValidationError.invalidField;
      newState = stateForm.copyWith(passwordError: passwordError);
    }

    final isFormValid =
        newState.emailError == ValidationError.noError && newState.passwordError == ValidationError.noError;
    return newState.copyWith(
      emailError: newState.emailError,
      passwordError: newState.passwordError,
      isFormValid: isFormValid,
    );
  }
}
