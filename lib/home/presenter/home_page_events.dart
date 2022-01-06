import '../ui/ui.dart';

class HomeValidateForm implements HomeEvent {
  String fieldName;
  String? value;
  HomeValidateForm({required this.fieldName, this.value});
}
