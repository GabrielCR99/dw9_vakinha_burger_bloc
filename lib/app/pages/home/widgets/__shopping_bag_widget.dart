part of '../home_page.dart';

class _ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;

  const _ShoppingBagWidget({required this.bag});

  @override
  Widget build(BuildContext context) {
    final totalBag = bag
        .fold<double>(
          0,
          (previousValue, element) => previousValue + element.totalPrice,
        )
        .currencyPtBr;

    return Container(
      width: context.width,
      height: 90,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
        onPressed: () => _goToOrder(context),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.shopping_cart_outlined),
            ),
            Align(
              child: Text(
                'Ver sacola',
                style: context.textStyles.textExtraBold.copyWith(fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBag,
                style: context.textStyles.textExtraBold.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sp = await SharedPreferences.getInstance();

    if (!sp.containsKey('accessToken')) {
      final loginResult = await navigator.pushNamed('/auth/login');

      if (loginResult == null || loginResult == false) {
        return;
      }
    }

    final updatedBag = await navigator.pushNamed('/order', arguments: bag);
    controller.updateBag(
      (updatedBag ?? const <OrderProductDto>[]) as List<OrderProductDto>,
    );
  }
}
