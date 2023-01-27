import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/register_controller.dart';
import 'register_page.dart';

class RegisterRouter extends StatelessWidget {
  const RegisterRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterController(authRepository: context.read()),
      child: const RegisterPage(),
    );
  }
}
