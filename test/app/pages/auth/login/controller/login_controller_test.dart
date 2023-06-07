import 'package:bloc_test/bloc_test.dart';
import 'package:dw9_vakinha_burger_bloc/app/pages/auth/login/controller/login_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import '../mocks/mock_auth_repository.dart';

void main() {
  late LoginState state;
  late MockAuthRepository repository;
  late LoginController controller;

  setUp(() {
    SharedPreferences.setMockInitialValues(
      {'accessToken': 'accessToken', 'refreshToken': 'refreshToken'},
    );
    state = const LoginState.initial();
    repository = MockAuthRepository();
    controller = LoginController(authRepository: repository);
  });

  tearDownAll(() => controller.close());

  group('Group test login', () {
    blocTest<LoginController, LoginState>(
      'emits [LoginStatus.login, LoginStatus.success] when login is called '
      'with success.',
      build: () => controller,
      setUp: () => repository.mockLoginSuccess(),
      act: (bloc) => controller.login(email: 'email', password: 'password'),
      expect: () => <LoginState>[
        state.copyWith(status: LoginStatus.login),
        state.copyWith(status: LoginStatus.success),
      ],
      verify: (_) =>
          verify(() => repository.login(email: 'email', password: 'password'))
              .called(1),
    );

    blocTest<LoginController, LoginState>(
      'emits [LoginStatus.login, LoginStatus.loginError] when login is called '
      'with error.',
      build: () => controller,
      setUp: () => repository.mockLoginError(),
      act: (bloc) => controller.login(email: 'email', password: 'password'),
      expect: () => <LoginState>[
        state.copyWith(status: LoginStatus.login),
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: 'Erro ao fazer login',
        ),
      ],
      verify: (_) =>
          verify(() => repository.login(email: 'email', password: 'password'))
              .called(1),
    );

    blocTest<LoginController, LoginState>(
      'emits [LoginStatus.login, LoginStatus.error] when login is called '
      'with error.',
      build: () => controller,
      setUp: () => repository.mockLoginUnauthorized(),
      act: (bloc) => controller.login(email: 'email', password: 'password'),
      expect: () => <LoginState>[
        state.copyWith(status: LoginStatus.login),
        state.copyWith(
          status: LoginStatus.loginError,
          errorMessage: 'Erro ao fazer login',
        ),
      ],
      verify: (_) =>
          verify(() => repository.login(email: 'email', password: 'password'))
              .called(1),
    );
  });
}
