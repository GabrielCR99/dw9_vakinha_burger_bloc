import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/unauthorized_exception.dart';
import '../../../../repositories/auth/auth_repository.dart';
import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.login));

    try {
      final authModel =
          await _authRepository.login(email: email, password: password);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('accessToken', authModel.accessToken);
      await sp.setString('refreshToken', authModel.refreshToken);

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
