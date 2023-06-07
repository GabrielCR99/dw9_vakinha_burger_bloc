import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import 'controller/product_detail_controller.dart';
import 'product_detail_page.dart';

class ProductDetailModule extends BlocProvider<ProductDetailController> {
  ProductDetailModule({super.key})
      : super(
          create: (_) => ProductDetailController(),
          child: Builder(
            builder: (context) {
              final args = ModalRoute.of(context)!.settings.arguments!
                  as Map<String, dynamic>;

              return ProductDetailPage(
                product: args['product'] as ProductModel,
                productOrder: args['order'] as OrderProductDto?,
              );
            },
          ),
        );
}
