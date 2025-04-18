import 'package:dw9_vakinha_burger_bloc/app/core/exceptions/repository_exception.dart';
import 'package:dw9_vakinha_burger_bloc/app/core/exceptions/unauthorized_exception.dart';
import 'package:dw9_vakinha_burger_bloc/app/repositories/auth/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

final class MockAuthRepository extends Mock implements AuthRepository {
  void mockLoginSuccess() => when(
    () => login(email: any(named: 'email'), password: any(named: 'password')),
  ).thenAnswer(
    (_) async => const (accessToken: 'token', refreshToken: 'refreshToken'),
  );

  void mockLoginError() => when(
    () => login(email: any(named: 'email'), password: any(named: 'password')),
  ).thenThrow((_) async => const RepositoryException(message: 'error'));

  void mockLoginUnauthorized() => when(
    () => login(email: any(named: 'email'), password: any(named: 'password')),
  ).thenThrow(UnauthorizedException());
}
