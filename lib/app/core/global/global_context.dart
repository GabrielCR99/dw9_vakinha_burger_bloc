import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GlobalContext {
  // ! Never let this key public
  late final GlobalKey<NavigatorState> _navigatorKey;

  GlobalContext._();

  static GlobalContext? _instance;

  static GlobalContext get i {
    _instance ??= GlobalContext._();

    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> navigatorKey) =>
      _navigatorKey = navigatorKey;

  Future<void> loginExpire() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    showTopSnackBar(
      _navigatorKey.currentState!.overlay!,
      const CustomSnackBar.error(
        message: 'Login expirado! Clique na sacola novamente.',
        backgroundColor: Colors.black,
      ),
    );
    _navigatorKey.currentState!.popUntil(ModalRoute.withName('/home'));
  }
}
