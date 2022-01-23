import 'package:bloc_test/domain/entities/entities.dart';

class RemoteAuthCredentials extends AuthCredentialsEntity {
  RemoteAuthCredentials({
    required String tokenDTO,
    required uidDTO,
  }) : super(
          token: tokenDTO,
          uid: uidDTO,
        );

  factory RemoteAuthCredentials.fromJSON(Map<String, dynamic> map) {
    return RemoteAuthCredentials(tokenDTO: map['token'], uidDTO: map['uid']);
  }
}
