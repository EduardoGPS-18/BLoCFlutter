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
    on<HomeEventCloseProccess>(_closeProccessResult);
    on<HomeEventClosePage>(_closePage);
  }

  Future<void> _submitForm(HomeEventSubmit event, Emitter<HomeState> emit) async {
    final formState = state as HomeStateEnterForm;
    emit(formState.copyWith(proccessLoading: ProccessLoading.start));

    loginUseCase(email: formState.email, password: formState.password);

    emit(formState.copyWith(proccessLoading: ProccessLoading.end));
    await Future.delayed(const Duration(milliseconds: 20));
    emit(formState.copyWith(proccessLoading: ProccessLoading.none));

    await Future.delayed(const Duration(milliseconds: 100));

    emit(formState.copyWith(proccessResult: ProccessResult.success));
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

  Future<void> _closeProccessResult(HomeEventCloseProccess event, Emitter<HomeState> emit) async {
    final formState = await _closeProccessIfItsOpen(emit);
    emit(formState.copyWith(proccessResult: ProccessResult.none));
  }

  Future<void> _closePage(HomeEventClosePage event, Emitter<HomeState> emit) async {
    final formState = await _closeProccessIfItsOpen(emit);
    emit(formState.copyWith(closePage: true));
    await Future.delayed(const Duration(milliseconds: 20));
  }
}

extension HomeBlocHelpers on HomeBloc {
  Future<HomeStateEnterForm> _closeProccessIfItsOpen(Emitter<HomeState> emit) async {
    final formState = state as HomeStateEnterForm;
    if (formState.proccessResult.isOpen) {
      emit(formState.copyWith(proccessResult: ProccessResult.close));
      await Future.delayed(const Duration(milliseconds: 20));
    }
    return formState;
  }
}
