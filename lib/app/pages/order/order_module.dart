import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../repositories/order/order_repository.dart';
import '../../repositories/order/order_repository_impl.dart';
import 'controller/order_controller.dart';
import 'order_page.dart';

class OrderModule extends MultiProvider {
  OrderModule({super.key, super.child = const OrderPage()})
      : super(
          providers: [
            RepositoryProvider<OrderRepository>(
              create: (context) => OrderRepositoryImpl(dio: context.read()),
              lazy: true,
            ),
            BlocProvider(
              create: (context) =>
                  OrderController(orderRepository: context.read()),
            ),
          ],
        );
}
