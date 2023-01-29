part of '../order_page.dart';

class _OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto orderProduct;

  const _OrderProductTile({required this.index, required this.orderProduct});

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
