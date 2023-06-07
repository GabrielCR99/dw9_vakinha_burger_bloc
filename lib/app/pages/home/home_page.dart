import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/extensions/formatter_extension.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/app_colors.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/delivery_app_bar.dart';
import '../../core/ui/widgets/loading/loading_screen.dart';
import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import 'controller/home_controller.dart';

part 'widgets/__delivery_product_tile.dart';
part 'widgets/__shopping_bag_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _homeListener(BuildContext context, HomeState state) {
    switch (state.status) {
      case HomeStatus.initial:
      case HomeStatus.loading:
        context.showLoader();
      case HomeStatus.loaded:
        context.hideLoader();
      case HomeStatus.error:
        context.hideLoader();
        context.showError(state.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: BlocConsumer<HomeController, HomeState>(
        builder: (_, state) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  final product = state.products[index];
                  final orders = state.bag.where((e) => e.product == product);

                  return _DeliveryProductTile(
                    product: product,
                    productOrder: orders.isNotEmpty ? orders.first : null,
                  );
                },
                itemCount: state.products.length,
              ),
            ),
            if (state.bag.isNotEmpty)
              _ShoppingBagWidget(bag: state.bag)
            else
              const SizedBox.shrink(),
          ],
        ),
        listener: _homeListener,
        buildWhen: (_, current) =>
            switch (current.status) { HomeStatus.loaded => true, _ => false },
      ),
    );
  }
}
