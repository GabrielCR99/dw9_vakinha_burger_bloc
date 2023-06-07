part of '../../../dw_delivery_app.dart';

final _defaultInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey[400]!),
  borderRadius: const BorderRadius.all(Radius.circular(7)),
);

final _theme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyles.i.textRegular.copyWith(color: Colors.black),
    errorStyle: TextStyles.i.textRegular.copyWith(color: Colors.redAccent),
    isDense: true,
    contentPadding: const EdgeInsets.all(13),
    filled: true,
    fillColor: Colors.white,
    focusedBorder: _defaultInputBorder,
    enabledBorder: _defaultInputBorder,
    border: _defaultInputBorder,
  ),
  useMaterial3: true,
  cardColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.i.primary,
    primary: AppColors.i.primary,
    secondary: AppColors.i.secondary,
    onSecondary: Colors.white,
  ),
  primaryColor: AppColors.i.primary,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  elevatedButtonTheme:
      ElevatedButtonThemeData(style: AppStyles.i.primaryButton),
);
