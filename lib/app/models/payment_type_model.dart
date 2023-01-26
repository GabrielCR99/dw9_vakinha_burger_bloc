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

  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) =>
      PaymentTypeModel(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        acronym: map['acronym'] ?? '',
        enabled: map['enabled'] ?? false,
      );
}
