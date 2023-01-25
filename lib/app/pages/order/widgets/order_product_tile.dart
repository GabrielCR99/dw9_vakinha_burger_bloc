import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/formatter_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_increment_decrement_button.dart';
import '../../../dto/order_product_dto.dart';
import '../controller/order_controller.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto orderProduct;

  const OrderProductTile({
    required this.index,
    required this.orderProduct,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = orderProduct.product;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: product.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style:
                        context.textStyles.textRegular.copyWith(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (orderProduct.amount * product.price).currencyPtBr,
                        style: context.textStyles.textMedium.copyWith(
                          fontSize: 14,
                          color: context.appColors.secondary,
                        ),
                      ),
                      DeliveryIncrementDecrementButton.compact(
                        amount: orderProduct.amount,
                        onIncrement: () => context
                            .read<OrderController>()
                            .incrementProduct(index),
                        onDecrement: () => context
                            .read<OrderController>()
                            .decrementProduct(index),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
