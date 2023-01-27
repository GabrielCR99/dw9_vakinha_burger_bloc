import '../models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amount;

  const OrderProductDto({required this.product, required this.amount});

  double get totalPrice => product.price * amount;

  OrderProductDto copyWith({required int amount, ProductModel? product}) =>
      OrderProductDto(product: product ?? this.product, amount: amount);
}
