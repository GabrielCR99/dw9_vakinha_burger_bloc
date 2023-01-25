import 'dart:convert';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'price': price,
      };

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        image: map['image'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
      );

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
