import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/order/order_repository.dart';
import '../../repositories/order/order_repository_impl.dart';
import 'controller/order_controller.dart';
import 'order_page.dart';

class OrderRouter extends StatelessWidget {
  const OrderRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<OrderRepository>(
      create: (_) => OrderRepositoryImpl(dio: context.read()),
      child: BlocProvider(
        create: (context) => OrderController(orderRepository: context.read()),
        child: const OrderPage(),
      ),
    );
  }
}
