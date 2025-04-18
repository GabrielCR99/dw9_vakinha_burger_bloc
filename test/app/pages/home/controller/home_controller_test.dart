import 'package:bloc_test/bloc_test.dart';
import 'package:dw9_vakinha_burger_bloc/app/core/rest_client/custom_dio.dart';
import 'package:dw9_vakinha_burger_bloc/app/dto/order_product_dto.dart';
import 'package:dw9_vakinha_burger_bloc/app/models/product_model.dart';
import 'package:dw9_vakinha_burger_bloc/app/pages/home/controller/home_controller.dart';
import 'package:dw9_vakinha_burger_bloc/app/repositories/products/products_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

final class MockProductsRepository extends Mock implements ProductsRepository {}

final class MockDio extends Mock implements CustomDio {
  MockDio() {
    when(auth).thenReturn(this);
    when(unauth).thenReturn(this);
  }
}

void main() {
  late HomeState state;
  final productsRepository = MockProductsRepository();
  late HomeController homeController;
  late List<ProductModel> products;
  late OrderProductDto productOrder;

  setUp(() {
    state = const HomeState.initial();
    homeController = HomeController(productsRepository: productsRepository);
    products = const [
      (
        id: 1,
        name: 'X-Burger',
        description: 'Hamburguer de carne bovina, queijo, alface e tomate',
        image: 'https://i.imgur.com/6Z0ZQYq.png',
        price: 10,
      ),
      (
        id: 2,
        name: 'X-Bacon',
        description:
            'Hamburguer de carne bovina, bacon, queijo, alface e tomate',
        image: 'https://i.imgur.com/6Z0ZQYq.png',
        price: 12,
      ),
    ];
    productOrder = const OrderProductDto(
      product: (
        id: 1,
        name: 'X-Burger',
        description: 'Hamburguer de carne bovina, queijo, alface e tomate',
        image: 'https://i.imgur.com/6Z0ZQYq.png',
        price: 10,
      ),
      amount: 1,
    );
  });

  group('Group test loadProducts', () {
    blocTest<HomeController, HomeState>(
      'emits [const HomeState(status: HomeStatus.loading, products: [], '
      'bag: []), HomeState(status: HomeStatus.loaded, products: products, '
      'bag: const [])] when loadProducts is called',
      build: () => homeController,
      setUp:
          () => when(
            productsRepository.findAll,
          ).thenAnswer((_) async => products),
      seed: () => state,
      act: (controller) => controller.loadProducts(),
      expect:
          () => <HomeState>[
            state.copyWith(status: HomeStatus.loading),
            state.copyWith(status: HomeStatus.loaded, products: products),
          ],
      verify: (_) => verify(productsRepository.findAll).called(1),
    );

    blocTest<HomeController, HomeState>(
      'emits const [HomeState(status: HomeStatus.loading, products: [], '
      'bag: []), HomeState(status: HomeStatus.error, products: [], bag: [])] '
      'when loadProducts is called',
      build: () => homeController,
      setUp: () => when(productsRepository.findAll).thenThrow(Exception()),
      seed: () => state,
      act: (controller) => controller.loadProducts(),
      expect:
          () => <HomeState>[
            state.copyWith(status: HomeStatus.loading),
            state.copyWith(
              status: HomeStatus.error,
              errorMessage: 'Erro ao buscar produtos',
            ),
          ],
      verify: (_) => verify(productsRepository.findAll).called(1),
    );
  });

  group('Group test addOrUpdateBag', () {
    blocTest<HomeController, HomeState>(
      'Should add product in bag',
      build: () => homeController,
      seed: () => state,
      act: (controller) => controller.addOrUpdateBag(productOrder),
      expect:
          () => <HomeState>[
            state.copyWith(bag: [productOrder]),
          ],
    );

    /*     blocTest<HomeController, HomeState>(
      'Should update product in bag',
      build: () => homeController,
      seed: () => state.copyWith(bag: [productOrder]),
      act: (controller) => controller.addOrUpdateBag(productOrder),
      expect: () => <HomeState>[
        state.copyWith(bag: [productOrder.copyWith(amount: 2)]),
      ],
    ); */
  });
}
