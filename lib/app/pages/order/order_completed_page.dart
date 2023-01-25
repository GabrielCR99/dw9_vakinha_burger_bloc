import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/delivery_button.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: context.percentHeight(0.2)),
              Image.asset('assets/images/logo_rounded.png'),
              const SizedBox(height: 10),
              Text(
                'Pedido realizado com sucesso, em breve você receberá a confirmação do seu pedido!',
                style: context.textStyles.textExtraBold.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              DeliveryButton(
                label: 'FECHAR',
                onPressed: () => Navigator.of(context).pop(),
                width: context.percentWidth(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
