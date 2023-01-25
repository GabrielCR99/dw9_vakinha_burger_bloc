import 'package:flutter/material.dart';

class DeliveryAppBar extends AppBar {
  DeliveryAppBar({super.key, double elevation = 1})
      : super(
          elevation: elevation,
          title: Image.asset('assets/images/logo.png', width: 80),
        );
}
