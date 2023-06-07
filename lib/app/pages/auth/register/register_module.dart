import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'controller/register_controller.dart';
import 'register_page.dart';

class RegisterModule extends MultiProvider {
  RegisterModule({super.key, super.child = const RegisterPage()})
      : super(
          providers: [
            BlocProvider(
              create: (context) =>
                  RegisterController(authRepository: context.read()),
            ),
          ],
        );
}
