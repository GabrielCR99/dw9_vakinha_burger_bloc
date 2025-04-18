part of 'home_controller.dart';

enum HomeStatus { initial, loading, loaded, error }

final class HomeState extends Equatable {
  final HomeStatus status;
  final List<ProductModel> products;
  final String? errorMessage;
  final List<OrderProductDto> bag;

  const HomeState({
    required this.status,
    required this.products,
    required this.bag,
    this.errorMessage,
  });

  const HomeState.initial()
    : status = HomeStatus.initial,
      products = const [],
      errorMessage = null,
      bag = const [];

  @override
  List<Object?> get props => [status, products, errorMessage, bag];

  HomeState copyWith({
    HomeStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    List<OrderProductDto>? bag,
  }) => HomeState(
    status: status ?? this.status,
    products: products ?? this.products,
    bag: bag ?? this.bag,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
