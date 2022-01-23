import 'package:bloc_test/presentation/validations/validation.dart';

import '../protocols/protocols.dart';

class CheckboxValidation implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const CheckboxValidation({
    required this.field,
  });

  @override
  ValidationError validate(Map input) {
    return input[field] == true ? ValidationError.noError : ValidationError.invalidField;
  }
}
