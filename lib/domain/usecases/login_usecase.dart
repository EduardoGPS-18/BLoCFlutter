import 'package:bloc_test/domain/entities/entities.dart' show AuthCredentialsEntity;

abstract class LoginUseCase {
  Future<AuthCredentialsEntity> call({required String email, required String password});
}
