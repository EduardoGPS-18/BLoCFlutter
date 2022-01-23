import 'package:bloc_test/presentation/validations/validation.dart';

import '../protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  @override
  final String field;

  const EmailValidation(this.field);

  @override
  List get props => [field];

  @override
  ValidationError validate(Map input) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = input[field].isNotEmpty && regex.hasMatch(input[field]);

    // print('ta bom entao -- $isValid -- field: ${input[field]}');
    return isValid ? ValidationError.noError : ValidationError.invalidField;
  }
}
