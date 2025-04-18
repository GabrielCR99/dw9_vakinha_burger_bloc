import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../repositories/products/products_repository.dart';
import '../../repositories/products/products_repository_impl.dart';
import 'controller/home_controller.dart';
import 'home_page.dart';

final class HomeModule extends MultiProvider {
  HomeModule({super.key})
    : super(
        providers: [
          RepositoryProvider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(dio: context.read()),
            lazy: true,
          ),
          BlocProvider(
            create:
                (context) => HomeController(productsRepository: context.read()),
          ),
        ],
        builder: (context, _) => HomePage(controller: context.read()),
      );
}
