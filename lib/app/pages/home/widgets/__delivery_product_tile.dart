part of '../home_page.dart';

class _DeliveryProductTile extends StatelessWidget {
  final ProductModel product;
  final OrderProductDto? productOrder;

  const _DeliveryProductTile({
    required this.product,
    this.productOrder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => _onPressedProduct(context),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.name,
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.description,
                      style:
                          context.textStyles.textRegular.copyWith(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.price.currencyPtBr,
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 12,
                        color: context.appColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: product.image,
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressedProduct(BuildContext context) async {
    final controller = context.read<HomeController>();
    final productOrderResult = await Navigator.of(context).pushNamed(
      '/product_detail',
      arguments: {'product': product, 'order': productOrder},
    ) as OrderProductDto?;

    if (productOrderResult != null) {
      controller.addOrUpdateBag(productOrderResult);
    }
  }
}
