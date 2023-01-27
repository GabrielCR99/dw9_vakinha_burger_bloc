import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/custom_text_form_field.dart';
import '../../../core/ui/widgets/delivery_app_bar.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import 'controller/register_controller.dart';
import 'controller/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (_, state) => state.status.matchAny(
        any: hideLoader,
        register: showLoader,
        success: () {
          hideLoader();
          showSuccess('Usuário registrado com sucesso');
          Navigator.of(context).pop();
        },
        error: () {
          hideLoader();
          showError('Erro ao registrar usuário');
        },
      ),
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
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
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
                    controller: _passwordEC,
                    label: 'Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                        6,
                        'Senha deve ter no mínimo 6 caracteres',
                      ),
                    ]),
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    label: 'Confirmar senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.compare(
                        _passwordEC,
                        'As senhas não são iguais',
                      ),
                    ]),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: DeliveryButton(
                      label: 'Cadastrar',
                      onPressed: _onPressedRegister,
                      width: double.infinity,
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
