import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../dto/order_dto.dart';
import '../../../dto/order_product_dto.dart';
import '../../../repositories/order/order_repository.dart';
import 'order_state.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _repository;

  OrderController({required OrderRepository orderRepository})
      : _repository = orderRepository,
        super(const OrderState.initial());

  Future<void> load(List<OrderProductDto> products) async {
    emit(state.copyWith(status: OrderStatus.loading));

    try {
      final payments = await _repository.getPaymentTypes();
      emit(
        state.copyWith(
          products: products,
          status: OrderStatus.loaded,
          payments: payments,
        ),
      );
    } catch (e, s) {
      log('Erro ao buscar tipos de pagamento', error: e, stackTrace: s);

      emit(
        state.copyWith(
          status: OrderStatus.error,
          errorMessage: 'Erro ao buscar tipos de pagamento',
        ),
      );
    }
  }

  void incrementProduct(int index) {
    final orders = [...state.products];
    final order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(state.copyWith(products: orders, status: OrderStatus.updatedOrder));
  }

  void decrementProduct(int index) {
    final orders = [...state.products];
    final order = orders[index];
    final amount = order.amount;

    if (amount == 1) {
      if (state.status != OrderStatus.confirmDeleteProduct) {
        emit(
          OrderConfirmDeleteProductState(
            product: order,
            index: index,
            status: OrderStatus.confirmDeleteProduct,
            products: state.products,
            payments: state.payments,
            errorMessage: state.errorMessage,
          ),
        );

        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: amount - 1);
    }

    if (orders.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));

      return;
    }
    emit(state.copyWith(products: orders, status: OrderStatus.updatedOrder));
  }

  void cancelDeleteProcess() =>
      emit(state.copyWith(status: OrderStatus.loaded));

  void emptyBag() => emit(state.copyWith(status: OrderStatus.emptyBag));

  Future<void> saveOrder({
    required String address,
    required String document,
    required int paymentMethodId,
  }) async {
    emit(state.copyWith(status: OrderStatus.loading));

    try {
      await _repository.saveOrder(
        OrderDto(
          products: state.products,
          address: address,
          document: document,
          paymentMethodId: paymentMethodId,
        ),
      );
      emit(state.copyWith(status: OrderStatus.success));
    } catch (e, s) {
      log('Erro ao salvar pedido', error: e, stackTrace: s);

      emit(
        state.copyWith(
          status: OrderStatus.error,
          errorMessage: 'Erro ao salvar pedido',
        ),
      );
    }
  }
}
