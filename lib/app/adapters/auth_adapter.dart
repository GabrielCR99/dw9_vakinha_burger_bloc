import '../models/auth_model.dart';

extension type const AuthAdapter._(AuthModel _) {
  static AuthModel fromMap(Map<String, dynamic> map) => (
    accessToken: map['access_token'] as String? ?? '',
    refreshToken: map['refresh_token'] as String? ?? '',
  );
}
