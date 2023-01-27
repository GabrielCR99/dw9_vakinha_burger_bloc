import 'package:flutter/material.dart';

import 'core/global/global_context.dart';
import 'core/provider/application_binding.dart';
import 'core/ui/theme/theme_config.dart';
import 'pages/auth/login/login_router.dart';
import 'pages/auth/register/register_router.dart';
import 'pages/home/home_router.dart';
import 'pages/order/order_completed_page.dart';
import 'pages/order/order_router.dart';
import 'pages/product_detail/product_detail_router.dart';
import 'pages/splash/splash_page.dart';

class DwDeliveryApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  DwDeliveryApp({super.key}) {
    GlobalContext.i.navigatorKey = _navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        theme: theme,
        navigatorKey: _navigatorKey,
        title: 'Delivery App',
        routes: {
          '/': (_) => const SplashPage(),
          '/home': (_) => const HomeRouter(),
          '/product_detail': (_) => const ProductDetailRouter(),
          '/auth/login': (_) => const LoginRouter(),
          '/auth/register': (_) => const RegisterRouter(),
          '/order': (_) => const OrderRouter(),
          '/order/completed': (_) => const OrderCompletedPage(),
        },
      ),
    );
  }
}
