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
  email: '',
  emailError: ValidationError.requiredFieldWithoutBorder,
  password: '',
  passwordError: ValidationError.requiredFieldWithoutBorder,
  isFormValid: false,
);

class HomeBloc extends Bloc<HomeEvent, HomeState>
    with BlocPresenter
    implements HomePresenter {
  HomeBloc() : super(_initialState) {
    on<HomeValidateForm>(_validateField);
    on<HomeEventSubmit>(_submitForm);
  }

  Future<void> _submitForm(
    HomeEventSubmit event,
    Emitter<HomeState> emit,
  ) async {
    final formState = state as HomeStateEnterForm;
    final loginParams = {
      'email': formState.email,
      'password': formState.password
    };

    emit(HomeStateLoading());

    // USECASE LOGIN
    await Future.delayed(const Duration(seconds: 2), () {
      print('LOGIN FEITO COM $loginParams');
    });

    emit(_initialState.copyWith());
  }

  void _validateField(
    HomeValidateForm event,
    Emitter<HomeState> emit,
  ) {
    final stateForm = state as HomeStateEnterForm;
    final String fieldName = event.fieldName;
    final String? value = event.value;
    var newState = stateForm.copyWith();

    if (fieldName == 'email') {
      final emailError = value?.contains('@') == true
          ? ValidationError.noError
          : ValidationError.invalidField;
      newState = stateForm.copyWith(emailError: emailError, email: value);
    }
    if (fieldName == 'password') {
      final passwordError = (value?.length ?? 0) >= 10
          ? ValidationError.noError
          : ValidationError.invalidField;
      newState =
          stateForm.copyWith(passwordError: passwordError, password: value);
    }

    final isFormValid = newState.emailError == ValidationError.noError &&
        newState.passwordError == ValidationError.noError;

    emit(newState.copyWith(isFormValid: isFormValid));
  }
}
