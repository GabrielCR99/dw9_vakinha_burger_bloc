part of 'order_controller.dart';

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

final class OrderState extends Equatable {
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

final class OrderConfirmDeleteProductState extends OrderState {
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
