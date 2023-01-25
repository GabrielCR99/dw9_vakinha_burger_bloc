import 'package:bloc/bloc.dart';

class ProductDetailController extends Cubit<int> {
  ProductDetailController() : super(1);

  late final bool _hasOrder;

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
