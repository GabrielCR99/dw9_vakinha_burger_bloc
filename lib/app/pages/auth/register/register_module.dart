import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/register_controller.dart';
import 'register_page.dart';

final class RegisterModule extends BlocProvider<RegisterController> {
  RegisterModule({super.key, super.child = const RegisterPage()})
      : super(
          create: (context) =>
              RegisterController(authRepository: context.read()),
        );
}
