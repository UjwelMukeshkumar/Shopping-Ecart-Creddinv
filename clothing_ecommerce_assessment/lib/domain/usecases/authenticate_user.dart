import '../repositories/auth_repository.dart';

class AuthenticateUser {
  const AuthenticateUser(this.repository);
  final AuthRepository repository;
  Future<bool> call(String email, String password) =>
      repository.login(email: email, password: password);
}

/// Assessment terminology alias: dedicated login use case.
typedef LoginUseCase = AuthenticateUser;
