import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extensions/formatter_extension.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/delivery_app_bar.dart';
import '../../core/ui/widgets/delivery_increment_decrement_button.dart';
import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import 'controller/product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? productOrder;

  const ProductDetailPage({
    required this.product,
    super.key,
    this.productOrder,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void initState() {
    super.initState();
    final amount = widget.productOrder?.amount ?? 1;
    controller.initial(amount, hasOrder: widget.productOrder != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.product.image),
                fit: BoxFit.cover,
              ),
            ),
            width: context.width,
            height: context.percentHeight(0.4),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Text(widget.product.description),
              ),
            ),
          ),
          const Divider(color: Colors.black),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: context.percentWidth(0.5),
                height: 68,
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (_, amount) => DeliveryIncrementDecrementButton(
                    amount: amount,
                    onIncrement: controller.increment,
                    onDecrement: controller.decrement,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: context.percentWidth(0.5),
                height: 68,
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (_, amount) => ElevatedButton(
                    onPressed: () => _onPressedAddOrDelete(amount),
                    style: amount == 0
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.red)
                        : null,
                    child: amount > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Adicionar',
                                style: context.textStyles.textExtraBold
                                    .copyWith(fontSize: 13),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: AutoSizeText(
                                  (widget.product.price * amount).currencyPtBr,
                                  style: context.textStyles.textExtraBold
                                      .copyWith(fontSize: 13),
                                  minFontSize: 5,
                                  maxFontSize: 13,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Excluir produto',
                            style: context.textStyles.textExtraBold,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onPressedAddOrDelete(int amount) {
    if (amount == 0) {
      _showConfirmDelete(amount);
    } else {
      Navigator.of(context)
          .pop(OrderProductDto(product: widget.product, amount: amount));
    }
  }

  void _showConfirmDelete(int amount) => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Deseja excluir o produto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context)
                ..pop()
                ..pop(OrderProductDto(product: widget.product, amount: amount)),
              child: Text('Confirmar', style: context.textStyles.textBold),
            ),
          ],
        ),
        barrierDismissible: false,
      );
}
