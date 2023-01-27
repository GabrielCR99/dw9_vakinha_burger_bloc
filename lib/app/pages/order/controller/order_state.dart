import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../../dto/order_product_dto.dart';
import '../../../models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  error,
  updatedOrder,
  confirmDeleteProduct,
  emptyBag,
  success,
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderProductDto> products;
  final List<PaymentTypeModel> payments;
  final String? errorMessage;

  const OrderState._({
    required this.status,
    required this.products,
    required this.payments,
    this.errorMessage,
  });

  const OrderState.initial()
      : this._(
          status: OrderStatus.initial,
          products: const [],
          payments: const [],
          errorMessage: null,
        );

  double get totalOrder => products.fold(
        0,
        (previousValue, element) => previousValue + element.totalPrice,
      );

  @override
  List<Object?> get props => [status, products, payments, errorMessage];

  OrderState copyWith({
    required OrderStatus status,
    List<OrderProductDto>? products,
    List<PaymentTypeModel>? payments,
    String? errorMessage,
  }) =>
      OrderState._(
        status: status,
        products: products ?? this.products,
        payments: payments ?? this.payments,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class OrderConfirmDeleteProductState extends OrderState {
  final OrderProductDto product;
  final int index;

  const OrderConfirmDeleteProductState({
    required this.product,
    required this.index,
    required super.status,
    required super.products,
    required super.payments,
    super.errorMessage,
  }) : super._();
}
