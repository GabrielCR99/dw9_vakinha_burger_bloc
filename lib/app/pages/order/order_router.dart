import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../repositories/order/order_repository.dart';
import '../../repositories/order/order_repository_impl.dart';
import 'controller/order_controller.dart';
import 'order_page.dart';

class OrderRouter {
  const OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          RepositoryProvider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(dio: context.read()),
          ),
          BlocProvider(
            create: (context) =>
                OrderController(orderRepository: context.read()),
          ),
        ],
        child: const OrderPage(),
      );
}
