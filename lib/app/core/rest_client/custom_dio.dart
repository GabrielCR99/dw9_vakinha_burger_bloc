import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import '../config/env/env.dart';
import 'interceptors/auth_interceptor.dart';

class CustomDio extends DioForNative {
  final _authInterceptor = AuthInterceptor();

  CustomDio()
      : super(
          BaseOptions(
            baseUrl: Env.i['backend_base_url'] ?? '',
            connectTimeout: 5000,
            receiveTimeout: 60000,
          ),
        ) {
    interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  CustomDio auth() => this..interceptors.add(_authInterceptor);

  CustomDio unauth() => this..interceptors.remove(_authInterceptor);
}
