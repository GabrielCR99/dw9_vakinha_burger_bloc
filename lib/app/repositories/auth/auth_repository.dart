import '../../models/auth_model.dart';

abstract interface class AuthRepository {
  Future<void> register({
    required String email,
    required String name,
    required String password,
  });
  Future<AuthModel> login({required String email, required String password});
}
