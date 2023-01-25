import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../dto/order_dto.dart';
import '../../models/payment_type_model.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio _dio;

  const OrderRepositoryImpl({required CustomDio dio}) : _dio = dio;
  @override
  Future<List<PaymentTypeModel>> getPaymentTypes() async {
    try {
      final result = await _dio.auth().get('/payment-types');

      return (result.data as List)
          .cast<Map<String, dynamic>>()
          .map<PaymentTypeModel>(PaymentTypeModel.fromMap)
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar tipos de pagamento', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao buscar tipos de pagamento'),
        s,
      );
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await _dio.auth().post(
        '/orders',
        data: {
          'products': order.products
              .map(
                (e) => {
                  'id': e.product.id,
                  'amount': e.amount,
                  'total_price': e.totalPrice,
                },
              )
              .toList(),
          'user_id': '#userAuthRef',
          'address': order.address,
          'CPF': order.document,
          'payment_method_id': order.paymentMethodId,
        },
      );
    } on DioError catch (e, s) {
      log('Erro ao salvar pedido', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao salvar pedido'),
        s,
      );
    }
  }
}
