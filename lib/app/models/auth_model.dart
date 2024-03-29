final class AuthModel {
  final String accessToken;
  final String refreshToken;

  const AuthModel({required this.accessToken, required this.refreshToken});

  factory AuthModel.fromMap(Map<String, dynamic> map) => AuthModel(
        accessToken: map['access_token'] as String? ?? '',
        refreshToken: map['refresh_token'] as String? ?? '',
      );
}
