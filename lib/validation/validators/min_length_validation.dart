import 'package:bloc_test/presentation/validations/validation.dart';

import '../protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  @override
  final String field;
  final int size;

  const MinLengthValidation({required this.field, required this.size});

  @override
  List get props => [field, size];

  @override
  ValidationError validate(Map input) {
    return input[field].length >= size ? ValidationError.noError : ValidationError.minLength;
  }
}
