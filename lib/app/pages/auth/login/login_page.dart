import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/custom_text_form_field.dart';
import '../../../core/ui/widgets/delivery_app_bar.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import 'controller/login_controller.dart';
import 'controller/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (_, state) => state.status.matchAny(
        any: hideLoader,
        login: showLoader,
        success: () {
          hideLoader();
          Navigator.of(context).pop(true);
        },
        loginError: () {
          hideLoader();
          showError(state.errorMessage!);
        },
        error: () {
          hideLoader();
          showError('Erro ao fazer login');
        },
      ),
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login', style: context.textStyles.textTitle),
                      const SizedBox(height: 30),
                      CustomTextFormField(
                        controller: _emailEC,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validatorless.multiple([
                          Validatorless.required('Email obrigatório'),
                          Validatorless.email('Email inválido'),
                        ]),
                      ),
                      const SizedBox(height: 30),
                      CustomTextFormField(
                        controller: _passwordEC,
                        obscureText: true,
                        label: 'Senha',
                        validator: Validatorless.required('Senha obrigatória'),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: DeliveryButton(
                          label: 'Entrar',
                          width: double.infinity,
                          onPressed: _onPressedLogin,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não possui uma conta?',
                        style: context.textStyles.textBold,
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/auth/register'),
                        child: Text(
                          'Cadastre-se',
                          style: context.textStyles.textBold
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedLogin() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      controller.login(
        email: _emailEC.text,
        password: _passwordEC.text,
      );
    }
  }
}
