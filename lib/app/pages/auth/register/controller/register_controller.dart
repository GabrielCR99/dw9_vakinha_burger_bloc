import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../../repositories/auth/auth_repository.dart';
import 'register_state.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterState.initial());

  Future<void> register({
    required String email,
    required String name,
    required String password,
  }) async {
    emit(state.copyWith(status: RegisterStatus.register));

    try {
      await _authRepository.register(
        email: email,
        name: name,
        password: password,
      );

      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);

      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
