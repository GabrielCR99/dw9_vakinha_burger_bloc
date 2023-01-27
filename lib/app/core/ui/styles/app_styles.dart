import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'text_styles.dart';

class AppStyles {
  const AppStyles._();

  static AppStyles? _instance;

  static AppStyles get i {
    _instance ??= const AppStyles._();

    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        backgroundColor: AppColors.i.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        textStyle: TextStyles.i.textButtonLabel,
      );
}
