import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/unauthorized_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/auth_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;

  const AuthRepositoryImpl({required CustomDio dio}) : _dio = dio;

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _dio.unauth().post(
        '/auth',
        data: {'email': email, 'password': password},
      );

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        log('Permissão negada', error: e, stackTrace: s);

        Error.throwWithStackTrace(UnauthorizedException(), s);
      }

      log('Erro ao logar usuário', error: e, stackTrace: s);
      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao logar usuário'),
        s,
      );
    }
  }

  @override
  Future<void> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      await _dio.unauth().post(
        '/users',
        data: {'name': name, 'email': email, 'password': password},
      );
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao registrar usuário'),
        s,
      );
    }
  }
}
