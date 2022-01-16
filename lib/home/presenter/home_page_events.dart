import '../ui/ui.dart';

class HomeValidateForm implements HomeEvent {
  String fieldName;
  String? value;
  HomeValidateForm({required this.fieldName, this.value});
}

class HomeEventSubmit implements HomeEvent {}

class HomeEventCloseProccess implements HomeEvent {}

class HomeEventClosePage implements HomeEvent {}
