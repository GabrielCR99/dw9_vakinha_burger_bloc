import 'package:flutter/material.dart';

class TextStyles {
  const TextStyles._();
  static TextStyles? _instance;
  static TextStyles get i {
    _instance ??= const TextStyles._();

    return _instance!;
  }

  String get _font => 'mplus1';

  TextStyle get textLight =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: _font);

  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: _font);

  TextStyle get textMedium => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: _font,
      );

  TextStyle get textSemiBold => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: _font,
      );

  TextStyle get textBold => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: _font,
      );

  TextStyle get textExtraBold => TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: _font,
      );

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);

  TextStyle get textTitle => textExtraBold.copyWith(fontSize: 28);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
