part of '../../../dw_delivery_app.dart';

final _defaultInputBorder = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(7)),
  borderSide: BorderSide(color: Colors.grey[400]!),
);

final _theme = ThemeData(
  // useMaterial3: true,
  primaryColor: AppColors.i.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.i.primary,
    primary: AppColors.i.primary,
    secondary: AppColors.i.secondary,
  ),
  elevatedButtonTheme:
      ElevatedButtonThemeData(style: AppStyles.i.primaryButton),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    contentPadding: const EdgeInsets.all(13),
    border: _defaultInputBorder,
    enabledBorder: _defaultInputBorder,
    focusedBorder: _defaultInputBorder,
    labelStyle: TextStyles.i.textRegular.copyWith(color: Colors.black),
    errorStyle: TextStyles.i.textRegular.copyWith(color: Colors.redAccent),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
