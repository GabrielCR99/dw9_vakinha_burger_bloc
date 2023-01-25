import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/delivery_app_bar.dart';
import 'controller/home_controller.dart';
import 'controller/home_state.dart';
import 'widgets/delivery_product_tile.dart';
import 'widgets/shopping_bag_widget.dart';

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

                  return DeliveryProductTile(
                    product: product,
                    productOrder: orders.isNotEmpty ? orders.first : null,
                  );
                },
              ),
            ),
            if (state.bag.isNotEmpty)
              ShoppingBagWidget(bag: state.bag)
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
