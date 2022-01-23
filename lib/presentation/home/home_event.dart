abstract class HomeEvent {}

abstract class HomeValidateForm implements HomeEvent {
  String fieldName;
  String? value;
  HomeValidateForm({required this.fieldName, this.value});
}

class HomeValidateEmail extends HomeValidateForm {
  HomeValidateEmail({required String fieldName, String? value}) : super(fieldName: fieldName, value: value);
}

class HomeValidatePassword extends HomeValidateForm {
  HomeValidatePassword({required String fieldName, String? value}) : super(fieldName: fieldName, value: value);
}

class HomeEventSubmit implements HomeEvent {}

class HomeEventCloseProccess implements HomeEvent {}

class HomeEventClosePage implements HomeEvent {}
