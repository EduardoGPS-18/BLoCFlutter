import 'package:bloc_test/domain/entities/auth_credentials_entity.dart';
import 'package:bloc_test/domain/usecases/usecases.dart';

class RemoteLogin extends LoginUseCase {
  @override
  Future<AuthCredentialsEntity> call({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (email == 'email@mail.com' && password == 'password') {
      return AuthCredentialsEntity(uid: 'valid_uid', token: 'valid_token');
    }
    throw Exception();
  }
}
