import 'package:flutter/material.dart';

import 'core/global/global_context.dart';
import 'core/provider/application_binding.dart';
import 'core/ui/styles/app_colors.dart';
import 'core/ui/styles/app_styles.dart';
import 'core/ui/styles/text_styles.dart';
import 'pages/auth/login/login_module.dart';
import 'pages/auth/register/register_module.dart';
import 'pages/home/home_module.dart';
import 'pages/order/order_completed_page.dart';
import 'pages/order/order_module.dart';
import 'pages/product_detail/product_detail_module.dart';
import 'pages/splash/splash_page.dart';

part 'core/ui/theme/theme_config.dart';

final class DwDeliveryApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  DwDeliveryApp({super.key}) {
    GlobalContext.i.navigatorKey = _navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        home: const SplashPage(),
        routes: {
          '/home': (_) => HomeModule(),
          '/product_detail': (_) => ProductDetailModule(),
          '/auth/login': (_) => LoginModule(),
          '/auth/register': (_) => RegisterModule(),
          '/order': (_) => OrderModule(),
          '/order/completed': (_) => const OrderCompletedPage(),
        },
        title: 'Delivery App',
        theme: _theme,
      ),
    );
  }
}
