import '../models/product_model.dart';

extension type const ProductAdapter._(ProductModel _) {
  static ProductModel fromMap(Map<String, dynamic> map) => (
    id: map['id'] as int? ?? 0,
    name: map['name'] as String? ?? '',
    description: map['description'] as String? ?? '',
    image: map['image'] as String? ?? '',
    price: map['price'] as double? ?? 0.0,
  );
}
