import 'package:bloc/bloc.dart';

import '../helpers/helpers.dart';
import '../ui/ui.dart';
import 'presenter.dart';

enum ValidationError {
  noError,
  invalidField,
  requiredField,
}

final _initialState = HomeStateEnterForm(
  email: '',
  emailError: ValidationError.noError,
  password: '',
  passwordError: ValidationError.noError,
  isFormValid: true,
);

// Only stay on HomeBloc class, methods thats used to map an event to a new state
// any other helper method stay in helper extension (HomeBlocHelpers)
class HomeBloc extends Bloc<HomeEvent, HomeState> with BlocPresenter implements HomePresenter {
  HomeBloc() : super(_initialState) {
    on<HomeValidateForm>(_validateField);
    on<HomeEventSubmit>(_submitForm);
    on<HomeEventCloseProccess>(_closeProccessResult);
    on<HomeEventClosePage>(_closePage);
  }

  Future<void> _submitForm(HomeEventSubmit event, Emitter<HomeState> emit) async {
    final formState = state as HomeStateEnterForm;
    final loginParams = {'email': formState.email, 'password': formState.password};
    emit(formState.copyWith(proccessLoading: ProccessLoading.start));

    // USECASE LOGIN
    await Future.delayed(const Duration(milliseconds: 200), () {
      print('LOGIN FEITO COM $loginParams');
    });

    emit(formState.copyWith(proccessLoading: ProccessLoading.end));
    await Future.delayed(const Duration(milliseconds: 20));
    emit(formState.copyWith(proccessLoading: ProccessLoading.none));

    await Future.delayed(const Duration(milliseconds: 100));

    emit(formState.copyWith(proccessResult: ProccessResult.success));
  }

  void _validateField(HomeValidateForm event, Emitter<HomeState> emit) {
    final stateForm = state as HomeStateEnterForm;
    final String fieldName = event.fieldName;
    final String? value = event.value;
    var newState = stateForm.copyWith();

    if (fieldName == 'email') {
      final emailError = value?.contains('@') == true ? ValidationError.noError : ValidationError.invalidField;
      newState = stateForm.copyWith(emailError: emailError, email: value);
    }
    if (fieldName == 'password') {
      final passwordError = (value?.length ?? 0) >= 10 ? ValidationError.noError : ValidationError.invalidField;
      newState = stateForm.copyWith(passwordError: passwordError, password: value);
    }

    final isFormValid = newState.emailError == ValidationError.noError &&
        stateForm.email.isNotEmpty &&
        newState.passwordError == ValidationError.noError &&
        stateForm.password.isNotEmpty;

    emit(newState.copyWith(isFormValid: isFormValid));
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
