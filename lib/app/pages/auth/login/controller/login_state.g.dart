// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LoginStatusMatch on LoginStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() login,
      required T Function() success,
      required T Function() loginError,
      required T Function() error}) {
    final v = this;
    if (v == LoginStatus.initial) {
      return initial();
    }

    if (v == LoginStatus.login) {
      return login();
    }

    if (v == LoginStatus.success) {
      return success();
    }

    if (v == LoginStatus.loginError) {
      return loginError();
    }

    if (v == LoginStatus.error) {
      return error();
    }

    throw Exception('LoginStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? login,
      T Function()? success,
      T Function()? loginError,
      T Function()? error}) {
    final v = this;
    if (v == LoginStatus.initial && initial != null) {
      return initial();
    }

    if (v == LoginStatus.login && login != null) {
      return login();
    }

    if (v == LoginStatus.success && success != null) {
      return success();
    }

    if (v == LoginStatus.loginError && loginError != null) {
      return loginError();
    }

    if (v == LoginStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
