import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../exceptions/expire_token_exception.dart';
import '../../global/global_context.dart';
import '../custom_dio.dart';

final class AuthInterceptor extends Interceptor {
  final CustomDio _dio;

  AuthInterceptor({required CustomDio dio}) : _dio = dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');

    if (accessToken != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      try {
        if (err.requestOptions.path != '/auth/refresh') {
          await _refreshToken();
          await _retryRequest(err, handler);
        } else {
          await GlobalContext.i.loginExpire();
        }
      } catch (_) {
        await GlobalContext.i.loginExpire();
      }
    } else {
      return handler.next(err);
    }
  }

  Future<void> _refreshToken() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final refreshToken = sp.getString('refreshToken');

      if (refreshToken == null) {
        return;
      }

      final Response(:data) = await _dio.auth().put<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      await Future.wait([
        sp.setString('accessToken', data!['access_token'] as String),
        sp.setString('refreshToken', data['refresh_token'] as String),
      ]);
    } on DioException catch (e, s) {
      log('Erro ao realizar refresh token', error: e, stackTrace: s);
      Error.throwWithStackTrace(ExpireTokenException(), s);
    }
  }

  Future<void> _retryRequest(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final Response(:data, :statusCode, :statusMessage) = await _dio
        .request<Map<String, dynamic>>(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          ),
        );

    return handler.resolve(
      Response(
        data: data,
        requestOptions: requestOptions,
        statusCode: statusCode,
        statusMessage: statusMessage,
      ),
    );
  }
}
