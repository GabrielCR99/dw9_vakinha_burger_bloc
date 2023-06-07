import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/product_model.dart';
import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio _dio;

  const ProductsRepositoryImpl({required CustomDio dio}) : _dio = dio;

  @override
  Future<List<ProductModel>> findAll() async {
    try {
      final response = await _dio.unauth().get<List<Object?>>('/products');

      return (response.data ?? const [])
          .cast<Map<String, dynamic>>()
          .map<ProductModel>(ProductModel.fromMap)
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao buscar produtos'),
        s,
      );
    }
  }
}
