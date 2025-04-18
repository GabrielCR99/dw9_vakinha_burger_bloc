part of 'register_controller.dart';

enum RegisterStatus { initial, register, success, error }

final class RegisterState extends Equatable {
  final RegisterStatus status;

  const RegisterState._({required this.status});

  const RegisterState.initial() : status = RegisterStatus.initial;

  RegisterState copyWith({required RegisterStatus status}) =>
      RegisterState._(status: status);

  @override
  List<Object?> get props => [status];
}
