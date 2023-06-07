import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dto/order_product_dto.dart';
import '../../../models/product_model.dart';
import '../../../repositories/products/products_repository.dart';
part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _productsRepository;

  HomeController({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(const HomeState.initial()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final products = await _productsRepository.findAll();
      emit(state.copyWith(status: HomeStatus.loaded, products: products));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Erro ao buscar produtos',
        ),
      );
    }
  }

  void addOrUpdateBag(OrderProductDto productOrder) {
    final shoppingBag = [...state.bag];
    final orderIndex =
        shoppingBag.indexWhere((e) => e.product == productOrder.product);

    if (orderIndex != -1) {
      if (productOrder.amount == 0) {
        shoppingBag.removeAt(orderIndex);
      } else {
        shoppingBag[orderIndex] = productOrder;
      }
    } else {
      shoppingBag.add(productOrder);
    }

    emit(state.copyWith(bag: shoppingBag));
  }

  void updateBag(List<OrderProductDto> updatedBag) =>
      emit(state.copyWith(bag: updatedBag));
}
