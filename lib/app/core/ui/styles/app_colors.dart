import 'package:flutter/material.dart';

final class AppColors {
  static AppColors? _instance;

  const AppColors._();

  static AppColors get i {
    _instance ??= const AppColors._();

    return _instance!;
  }

  Color get primary => const Color(0xFF007D21);
  Color get secondary => const Color(0xFFF88B0C);
}

extension AppColorsExtension on BuildContext {
  AppColors get appColors => AppColors.i;
}
