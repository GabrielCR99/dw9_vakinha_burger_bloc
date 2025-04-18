import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../config/env/env.dart';
import 'interceptors/auth_interceptor.dart';

interface class CustomDio extends DioForNative {
  late final _authInterceptor = AuthInterceptor(dio: this);

  CustomDio()
    : super(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 60000),
          baseUrl: Env.i['backend_base_url'] ?? '',
        ),
      ) {
    if (kDebugMode) {
      interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  CustomDio auth() => this..interceptors.add(_authInterceptor);

  CustomDio unauth() => this..interceptors.remove(_authInterceptor);
}
