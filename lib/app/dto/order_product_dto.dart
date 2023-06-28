import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

final class OrderProductDto extends Equatable {
  final ProductModel product;
  final int amount;

  const OrderProductDto({required this.product, required this.amount});

  @override
  List<Object?> get props => [product, amount];

  double get totalPrice => product.price * amount;

  OrderProductDto copyWith({required int amount, ProductModel? product}) =>
      OrderProductDto(product: product ?? this.product, amount: amount);
}
