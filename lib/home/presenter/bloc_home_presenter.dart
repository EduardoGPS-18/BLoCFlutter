import 'package:bloc/bloc.dart';
import 'package:bloc_test/home/helpers/helpers.dart';

import '../ui/ui.dart';
import 'presenter.dart';

enum ValidationError {
  noError,
  invalidField,
  requiredField,
}

final _initialState = HomeStateEnterForm(
  emailError: null,
  passwordError: null,
);

class HomeBloc extends Bloc<HomeEvent, HomeState> with BlocPresenter implements HomePresenter {
  HomeBloc() : super(_initialState) {
    on<HomeValidateForm>(
      (event, emit) {
        emit(validateField(event.fieldName, event.value));
      },
    );
  }

  HomeStateEnterForm validateField(String fieldName, String? value) {
    final stateForm = state as HomeStateEnterForm;
    if (fieldName == 'email') {
      final emailError = value?.contains('@') == true ? ValidationError.noError : ValidationError.invalidField;
      final toSendEmail = stateForm.copyWith(HomeStateEnterForm(emailError: emailError));
      return toSendEmail;
    }
    if (fieldName == 'password') {
      final passwordError = (value?.length ?? 0) >= 10 ? ValidationError.noError : ValidationError.invalidField;
      return stateForm.copyWith(HomeStateEnterForm(passwordError: passwordError));
    }
    return HomeStateEnterForm();
  }
}
