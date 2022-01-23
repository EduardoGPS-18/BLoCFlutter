import '../../presentation/validations/validation.dart';
import '../protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  @override
  final String field;
  final String fieldToCompare;

  @override
  List get props => [field, fieldToCompare];

  const CompareFieldsValidation({
    required this.field,
    required this.fieldToCompare,
  });

  @override
  ValidationError validate(Map input) {
    return input[field] != null && input[fieldToCompare] != null && input[field] != input[fieldToCompare]
        ? ValidationError.fieldsDoNotMatch
        : ValidationError.noError;
  }
}
