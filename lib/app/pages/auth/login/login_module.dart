import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/login_controller.dart';
import 'login_page.dart';

final class LoginModule extends BlocProvider<LoginController> {
  LoginModule({super.key, super.child = const LoginPage()})
    : super(
        create: (context) => LoginController(authRepository: context.read()),
      );
}
