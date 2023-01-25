import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/products/products_repository.dart';
import '../../repositories/products/products_repository_impl.dart';
import 'controller/home_controller.dart';
import 'home_page.dart';

abstract class HomeRouter {
  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(dio: context.read()),
          ),
          Provider(
            create: (context) =>
                HomeController(productsRepository: context.read()),
          ),
        ],
        child: const HomePage(),
      );
}
