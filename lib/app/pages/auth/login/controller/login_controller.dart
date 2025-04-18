import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/unauthorized_exception.dart';
import '../../../../models/auth_model.dart';
import '../../../../repositories/auth/auth_repository.dart';

part 'login_state.dart';

final class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.login));

    try {
      final AuthModel(:accessToken, :refreshToken) = await _authRepository
          .login(email: email, password: password);
      final sp = await SharedPreferences.getInstance();
      await Future.wait<bool>([
        sp.setString('accessToken', accessToken),
        sp.setString('refreshToken', refreshToken),
      ]);

      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (_) {
      emit(
        state.copyWith(
          status: LoginStatus.loginError,
          errorMessage: 'Login ou senha inválidos',
        ),
      );
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);

      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: 'Erro ao fazer login',
        ),
      );
    }
  }
}
