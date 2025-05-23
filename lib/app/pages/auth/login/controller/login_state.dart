part of 'login_controller.dart';

enum LoginStatus { initial, login, success, loginError, error }

final class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;

  const LoginState._({required this.status, this.errorMessage});

  const LoginState.initial()
    : status = LoginStatus.initial,
      errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  LoginState copyWith({required LoginStatus status, String? errorMessage}) =>
      LoginState._(
        status: status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
