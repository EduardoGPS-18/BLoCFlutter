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

class HomeBloc extends Bloc<HomeEvent, HomeState> with BlocPresenter implements HomePresenter {
  HomeBloc() : super(_initialState) {
    on<HomeValidateForm>((event, emit) => emit(_validateField(event.fieldName, event.value)));
    on<HomeEventSubmit>((event, emit) => _submitForm());
  }

  @override
  Future<void> _submitForm() async {
    final formState = state as HomeStateEnterForm;
    final loginParams = {'email': formState.email, 'password': formState.password};

    emit(HomeStateLoading());

    // USECASE LOGIN
    await Future.delayed(const Duration(seconds: 2));

    emit(_initialState.copyWith());
  }

  HomeStateEnterForm _validateField(String fieldName, String? value) {
    final stateForm = state as HomeStateEnterForm;
    var newState = stateForm.copyWith();

    if (fieldName == 'email') {
      final emailError = value?.contains('@') == true ? ValidationError.noError : ValidationError.invalidField;
      newState = stateForm.copyWith(emailError: emailError, email: value);
    }
    if (fieldName == 'password') {
      final passwordError = (value?.length ?? 0) >= 10 ? ValidationError.noError : ValidationError.invalidField;
      newState = stateForm.copyWith(passwordError: passwordError, password: value);
    }

    final isFormValid =
        newState.emailError == ValidationError.noError && newState.passwordError == ValidationError.noError;

    return newState.copyWith(isFormValid: isFormValid);
  }
}
