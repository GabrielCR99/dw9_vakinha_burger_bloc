class AuthModel {
  final String accessToken;
  final String refreshToken;

  const AuthModel({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  factory AuthModel.fromMap(Map<String, dynamic> map) => AuthModel(
        accessToken: map['access_token'] ?? '',
        refreshToken: map['refresh_token'] ?? '',
      );
}
