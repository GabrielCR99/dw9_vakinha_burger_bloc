import '../models/payment_type_model.dart';

extension type const PaymentTypeAdapter._(PaymentTypeModel _) {
  static PaymentTypeModel fromMap(Map<String, dynamic> map) => (
    id: map['id'] as int? ?? 0,
    name: map['name'] as String? ?? '',
    acronym: map['acronym'] as String? ?? '',
    enabled: map['enabled'] as bool? ?? false,
  );
}
