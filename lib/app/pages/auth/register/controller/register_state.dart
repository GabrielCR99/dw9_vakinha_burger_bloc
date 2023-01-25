import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'register_state.g.dart';

@match
enum RegisterStatus { initial, register, success, error }

class RegisterState extends Equatable {
  final RegisterStatus status;

  const RegisterState._({required this.status});

  const RegisterState.initial() : status = RegisterStatus.initial;

  RegisterState copyWith({RegisterStatus? status}) => RegisterState._(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
