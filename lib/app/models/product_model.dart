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

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        image: map['image'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
      );
}
