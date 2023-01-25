import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/login_controller.dart';
import 'login_page.dart';

class LoginRouter {
  const LoginRouter._();

  static Widget get page => BlocProvider(
        create: (context) => LoginController(authRepository: context.read()),
        child: const LoginPage(),
      );
}
