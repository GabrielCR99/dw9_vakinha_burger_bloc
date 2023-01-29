import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/extensions/formatter_extension.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/app_colors.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/delivery_app_bar.dart';
import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import 'controller/home_controller.dart';
import 'controller/home_state.dart';

part 'widgets/__delivery_product_tile.dart';
part 'widgets/__shopping_bag_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() => controller.loadProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (_, state) => state.status.matchAny(
          any: hideLoader,
          loading: showLoader,
          loaded: hideLoader,
          error: () {
            hideLoader();
            showError(state.errorMessage!);
          },
        ),
        buildWhen: (_, current) =>
            current.status.matchAny(any: () => false, loaded: () => true),
        builder: (_, state) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.products.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  final product = state.products[index];
                  final orders = state.bag.where((e) => e.product == product);

                  return _DeliveryProductTile(
                    product: product,
                    productOrder: orders.isNotEmpty ? orders.first : null,
                  );
                },
              ),
            ),
            if (state.bag.isNotEmpty)
              _ShoppingBagWidget(bag: state.bag)
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
