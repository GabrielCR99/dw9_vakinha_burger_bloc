import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

final class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueNotifier<bool> _obscureTextVN;

  CustomTextFormField({
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.obscureText = false,
    this.onFieldSubmitted,
    super.key,
  }) : _obscureTextVN = ValueNotifier<bool>(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder:
          (_, obscureTextVNValue, __) => TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              suffixIcon:
                  obscureText
                      ? IconButton(
                        iconSize: 24,
                        onPressed:
                            () => _obscureTextVN.value = !obscureTextVNValue,
                        icon: Icon(
                          _getIcon(obscureTextVNValue),
                          color: context.appColors.primary,
                        ),
                      )
                      : null,
              counterText: '',
            ),
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureTextVNValue,
            onFieldSubmitted:
                onFieldSubmitted != null
                    ? (value) => _onFieldSubmitted(value, context)
                    : null,
            validator: validator,
          ),
    );
  }

  void _onFieldSubmitted(String value, BuildContext context) {
    FocusScope.of(context).unfocus();
    onFieldSubmitted?.call(value);
  }

  IconData _getIcon(bool obscureTextVNValue) =>
      obscureTextVNValue ? Icons.visibility : Icons.visibility_off;
}
