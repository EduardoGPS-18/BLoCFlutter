import 'package:bloc_test/presentation/validations/validation.dart';
import 'package:bloc_test/validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  ValidationError validate({required String field, required Map input}) {
    ValidationError error = ValidationError.noError;

    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(input);

      if (error != ValidationError.noError) {
        return error;
      }
    }
    return error;
  }
}
