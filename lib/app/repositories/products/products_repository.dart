import '../../models/product_model.dart';

abstract interface class ProductsRepository {
  Future<List<ProductModel>> findAll();
}
