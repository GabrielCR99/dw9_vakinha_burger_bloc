import 'package:intl/intl.dart';

extension FormatterExtension on double {
  String get currencyPtBr {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', name: r'R$');

    return currencyFormat.format(this);
  }
}
