import 'package:bloc_test/presentation/validations/validation.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidation implements FieldValidation {
  const RequiredFieldValidation({required this.field});

  @override
  final String field;

  @override
  List get props => [field];

  @override
  ValidationError validate(Map input) {
    return input[field].isNotEmpty == true ? ValidationError.noError : ValidationError.requiredField;
  }
}
