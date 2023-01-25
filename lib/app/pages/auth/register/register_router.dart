import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/register_controller.dart';
import 'register_page.dart';

class RegisterRouter {
  const RegisterRouter._();

  static Widget get page => BlocProvider(
        create: (context) => RegisterController(authRepository: context.read()),
        child: const RegisterPage(),
      );
}
