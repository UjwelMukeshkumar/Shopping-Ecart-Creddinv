import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // Assessment-only dummy credentials. Never hard-code real credentials in production.
  static const demoEmail = 'demo@threadco.com';
  static const demoPassword = 'Flutter123!';
  @override
  Future<bool> login({required String email, required String password}) async =>
      email.trim().toLowerCase() == demoEmail && password == demoPassword;

  @override
  Future<void> logout() async {}
}
