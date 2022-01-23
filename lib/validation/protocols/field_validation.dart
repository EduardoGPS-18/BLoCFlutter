import 'package:bloc_test/presentation/validations/validation.dart';

abstract class FieldValidation {
  String get field;
  ValidationError validate(Map input);
}
