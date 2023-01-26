import 'package:bloc_test/bloc_test.dart';
import 'package:dw9_vakinha_burger_bloc/app/core/rest_client/custom_dio.dart';
import 'package:dw9_vakinha_burger_bloc/app/models/product_model.dart';
import 'package:dw9_vakinha_burger_bloc/app/pages/home/controller/home_controller.dart';
import 'package:dw9_vakinha_burger_bloc/app/pages/home/controller/home_state.dart';
import 'package:dw9_vakinha_burger_bloc/app/repositories/products/products_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

class MockDio extends Mock implements CustomDio {
  MockDio() {
    when(auth).thenReturn(this);
    when(unauth).thenReturn(this);
  }
}

void main() {
  late HomeState state;
  late MockProductsRepository productsRepository;
  late HomeController homeController;
  late List<ProductModel> products;

  setUp(() {
    state = const HomeState(status: HomeStatus.initial, products: [], bag: []);
    productsRepository = MockProductsRepository();
    homeController = HomeController(productsRepository: productsRepository);
    products = const [
      ProductModel(
        id: 1,
        name: 'X-Burger',
        description: 'Hamburguer de carne bovina, queijo, alface e tomate',
        price: 10,
        image: 'https://i.imgur.com/6Z0ZQYq.png',
      ),
      ProductModel(
        id: 2,
        name: 'X-Bacon',
        description:
            'Hamburguer de carne bovina, bacon, queijo, alface e tomate',
        price: 12,
        image: 'https://i.imgur.com/6Z0ZQYq.png',
      ),
    ];
  });

  blocTest<HomeController, HomeState>(
    '''emits [const HomeState(status: HomeStatus.loading, products: [], bag: []), 
    HomeState(status: HomeStatus.loaded, products: products, bag: const [])] 
    when loadProducts is called''',
    build: () => homeController,
    act: (controller) => controller.loadProducts(),
    verify: (_) => verify(productsRepository.findAll).called(1),
    seed: () => state,
    setUp: () =>
        when(productsRepository.findAll).thenAnswer((_) async => products),
    expect: () => <HomeState>[
      state.copyWith(status: HomeStatus.loading),
      state.copyWith(status: HomeStatus.loaded, products: products),
    ],
  );

  blocTest<HomeController, HomeState>(
    '''emits const [HomeState(status: HomeStatus.loading, products: [], bag: []), 
    HomeState(status: HomeStatus.error, products: [], bag: [])] 
    when loadProducts is called''',
    build: () => homeController,
    act: (controller) => controller.loadProducts(),
    verify: (_) => verify(productsRepository.findAll).called(1),
    seed: () => state,
    setUp: () => when(productsRepository.findAll).thenThrow(Exception()),
    expect: () => <HomeState>[
      state.copyWith(status: HomeStatus.loading),
      state.copyWith(
        status: HomeStatus.error,
        errorMessage: 'Erro ao buscar produtos',
      ),
    ],
  );
}
