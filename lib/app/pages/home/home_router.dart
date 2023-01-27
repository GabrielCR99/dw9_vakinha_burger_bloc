import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/products/products_repository.dart';
import '../../repositories/products/products_repository_impl.dart';
import 'controller/home_controller.dart';
import 'home_page.dart';

class HomeRouter extends StatelessWidget {
  const HomeRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ProductsRepository>(
      create: (_) => ProductsRepositoryImpl(dio: context.read()),
      child: BlocProvider(
        create: (context) => HomeController(productsRepository: context.read()),
        child: const HomePage(),
      ),
    );
  }
}
