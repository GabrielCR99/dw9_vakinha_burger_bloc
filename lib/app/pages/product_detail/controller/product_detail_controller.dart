import 'package:flutter_bloc/flutter_bloc.dart';

final class ProductDetailController extends Cubit<int> {
  late final bool _hasOrder;

  ProductDetailController() : super(1);

  void initial(int amount, {bool hasOrder = false}) {
    _hasOrder = hasOrder;
    emit(amount);
  }

  void increment() => emit(state + 1);

  void decrement() {
    if (state > (_hasOrder ? 0 : 1)) {
      emit(state - 1);
    }
  }
}
