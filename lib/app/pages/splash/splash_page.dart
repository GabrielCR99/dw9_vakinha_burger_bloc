import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0XFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.width,
                child:
                    Image.asset('assets/images/lanche.png', fit: BoxFit.cover),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: context.percentHeight(0.3)),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 80),
                  DeliveryButton(
                    label: 'ACESSAR',
                    width: context.percentWidth(0.6),
                    height: 35,
                    onPressed: () =>
                        Navigator.of(context).popAndPushNamed('/home'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
