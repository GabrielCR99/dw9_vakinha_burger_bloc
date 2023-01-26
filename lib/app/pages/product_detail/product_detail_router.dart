import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/product_detail_controller.dart';
import 'product_detail_page.dart';

class ProductDetailRouter extends StatelessWidget {
  const ProductDetailRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailController(),
      child: Builder(
        builder: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

          return ProductDetailPage(
            product: args['product'],
            productOrder: args['order'],
          );
        },
      ),
    );
  }
}
