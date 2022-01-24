import 'package:bloc/bloc.dart';
import 'package:bloc_test/domain/usecases/usecases.dart';
import 'package:bloc_test/presentation/home/home.dart';
import 'package:bloc_test/presentation/validations/validation.dart';
import 'package:bloc_test/ui/ui.dart';

import '../helpers/helpers.dart';

final _initialState = HomeStateEnterForm(
  email: '',
  emailError: ValidationError.noError,
  password: '',
  passwordError: ValidationError.noError,
  isFormValid: true,
);

class HomeBloc extends Bloc<HomeEvent, HomeState> with BlocPresenter implements HomePresenter {
  LoginUseCase loginUseCase;
  Validation validation;

  HomeBloc({
    required this.loginUseCase,
    required this.validation,
  }) : super(_initialState) {
    on<HomeValidateForm>(_validateForm);
    on<HomeEventSubmit>(_submitForm);
  }

  Future<void> _submitForm(HomeEventSubmit event, Emitter<HomeState> emit) async {
    final formState = state as HomeStateEnterForm;
    emit(formState.copyWith(proccessLoading: ProccessLoading.loading));

    try {
      await loginUseCase(email: formState.email, password: formState.password);
    } on Exception {
      emit(formState.copyWith(proccessLoading: ProccessLoading.none));
      emit(formState.copyWith(proccessResult: ProccessResult.error));
      return;
    }
    emit(formState.copyWith(proccessResult: ProccessResult.success));
    emit(formState.copyWith(proccessResult: ProccessResult.none));
  }

  bool isFormValid(HomeStateEnterForm formState) {
    final isEmailValid = formState.emailError == ValidationError.noError && formState.email.isNotEmpty;
    final isPasswordValid = formState.passwordError == ValidationError.noError && formState.password.isNotEmpty;
    return isEmailValid && isPasswordValid;
  }

  void _validateForm(HomeValidateForm event, Emitter<HomeState> emit) {
    final formState = state as HomeStateEnterForm;
    HomeStateEnterForm newState = formState;
    if (event is HomeValidateEmail) {
      newState = _validateEmail(event, formState);
    } else if (event is HomeValidatePassword) {
      newState = _validatePassword(event, formState);
    }
    emit(newState.copyWith(isFormValid: isFormValid(newState)));
  }

  HomeStateEnterForm _validateEmail(HomeValidateEmail event, HomeStateEnterForm formState) {
    final error = validation.validate(field: event.fieldName, input: {
      'email': formState.email,
    });
    return formState.copyWith(emailError: error, email: event.value);
  }

  HomeStateEnterForm _validatePassword(HomeValidatePassword event, HomeStateEnterForm formState) {
    final error = validation.validate(field: event.fieldName, input: {
      'password': formState.password,
    });
    return formState.copyWith(passwordError: error, password: event.value);
  }
}
