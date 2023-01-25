import 'dart:convert';

class PaymentTypeModel {
  final int id;
  final String name;
  final String acronym;
  final bool enabled;

  const PaymentTypeModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.enabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'acronym': acronym,
      'enabled': enabled,
    };
  }

  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypeModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      acronym: map['acronym'] ?? '',
      enabled: map['enabled'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTypeModel.fromJson(String source) =>
      PaymentTypeModel.fromMap(json.decode(source));
}
