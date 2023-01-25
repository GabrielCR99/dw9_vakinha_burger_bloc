import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'controller/product_detail_controller.dart';
import 'product_detail_page.dart';

class ProductDetailRouter {
  const ProductDetailRouter._();

  static Widget get page => Provider(
        create: (_) => ProductDetailController(),
        builder: (context, _) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

          return ProductDetailPage(
            product: args['product'],
            productOrder: args['order'],
          );
        },
      );
}
