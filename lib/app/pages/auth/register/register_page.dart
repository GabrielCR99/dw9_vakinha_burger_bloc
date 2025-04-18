import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/custom_text_form_field.dart';
import '../../../core/ui/widgets/delivery_app_bar.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import 'controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final class _RegisterPageState
    extends BaseState<RegisterPage, RegisterController> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _registerListener(BuildContext context, RegisterState state) {
    switch (state.status) {
      case RegisterStatus.initial:
      case RegisterStatus.register:
        showLoader();
      case RegisterStatus.success:
        hideLoader();
        showSuccess('Usuário registrado com sucesso');
        Navigator.of(context).pop();
      case RegisterStatus.error:
        hideLoader();
        showError('Erro ao registrar usuário');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: _registerListener,
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cadastro', style: context.textStyles.textTitle),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro',
                    style: context.textStyles.textMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameEC,
                    decoration: const InputDecoration(label: Text('Nome')),
                    validator: Validatorless.required('Nome obrigatório'),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailEC,
                    decoration: const InputDecoration(label: Text('Email')),
                    keyboardType: TextInputType.emailAddress,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório'),
                      Validatorless.email('Email inválido'),
                    ]),
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    label: 'Senha',
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                        6,
                        'Senha deve ter no mínimo 6 caracteres',
                      ),
                    ]),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    label: 'Confirmar senha',
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.compare(
                        _passwordEC,
                        'As senhas não são iguais',
                      ),
                    ]),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: DeliveryButton(
                      label: 'Cadastrar',
                      width: double.infinity,
                      onPressed: _onPressedRegister,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  void _onPressedRegister() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      controller.register(
        email: _emailEC.text,
        name: _nameEC.text,
        password: _passwordEC.text,
      );
    }
  }
}
