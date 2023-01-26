import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/extensions/formatter_extension.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/delivery_app_bar.dart';
import '../../core/ui/widgets/delivery_button.dart';
import '../../dto/order_product_dto.dart';
import '../../models/payment_type_model.dart';
import 'controller/order_controller.dart';
import 'controller/order_state.dart';
import 'widgets/order_field.dart';
import 'widgets/order_product_tile.dart';
import 'widgets/payment_types_field.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final _formKey = GlobalKey<FormState>();
  final _addressEC = TextEditingController();
  final _documentEC = TextEditingController();
  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier(true);

  @override
  void onReady() {
    super.onReady();
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _addressEC.dispose();
    _documentEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (_, state) => state.status.matchAny(
        any: hideLoader,
        loading: showLoader,
        error: () {
          hideLoader();
          showError(state.errorMessage ?? 'Erro não informado');
        },
        confirmDeleteProduct: () {
          hideLoader();
          if (state is OrderConfirmDeleteProductState) {
            _showConfirmDeleteProduct(state);
          }
        },
        emptyBag: () {
          showInfo('Sua sacola está vazia! Adicione produtos para continuar.');
          Navigator.of(context).pop(const <OrderProductDto>[]);
        },
        success: () {
          hideLoader();
          Navigator.of(context).popAndPushNamed(
            '/order/completed',
            result: const <OrderProductDto>[],
          );
        },
      ),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: DeliveryAppBar(),
          body: Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Carrinho',
                          style: context.textStyles.textTitle,
                        ),
                        IconButton(
                          onPressed: controller.emptyBag,
                          icon: Image.asset('assets/images/trashRegular.png'),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocSelector<OrderController, OrderState,
                    List<OrderProductDto>>(
                  selector: (state) => state.products,
                  builder: (_, state) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.length,
                      (_, index) => Column(
                        children: [
                          OrderProductTile(
                            index: index,
                            orderProduct: state[index],
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total do pedido',
                              style: context.textStyles.textExtraBold
                                  .copyWith(fontSize: 16),
                            ),
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (_, totalOrder) => Text(
                                totalOrder.currencyPtBr,
                                style: context.textStyles.textExtraBold
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      OrderField(
                        title: 'Endereço de entrega',
                        hintText: 'Digite um endereço',
                        validator:
                            Validatorless.required('Endereço obrigatório'),
                        controller: _addressEC,
                      ),
                      const SizedBox(height: 10),
                      OrderField(
                        title: 'Cpf',
                        hintText: 'Digite o cpf',
                        validator: Validatorless.required('Cpf obrigatório'),
                        controller: _documentEC,
                      ),
                      const SizedBox(height: 20),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypeModel>>(
                        selector: (state) => state.payments,
                        builder: (_, payments) => ValueListenableBuilder(
                          valueListenable: paymentTypeValid,
                          builder: (_, paymentTypeValidValue, __) =>
                              PaymentTypesField(
                            payments: payments,
                            onChanged: (value) => paymentTypeId = value,
                            valid: paymentTypeValidValue,
                            selectedValue: '$paymentTypeId',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Divider(color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: DeliveryButton(
                          label: 'FINALIZAR',
                          width: double.infinity,
                          height: 48,
                          onPressed: _onPressedFinish,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pop(controller.state.products);

    return false;
  }

  void _onPressedFinish() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final hasSelectedPaymentType = paymentTypeId != null;
    paymentTypeValid.value = hasSelectedPaymentType;

    if (formValid && hasSelectedPaymentType) {
      controller.saveOrder(
        address: _addressEC.text,
        document: _documentEC.text,
        paymentMethodId: paymentTypeId!,
      );
    }
  }

  void _showConfirmDeleteProduct(OrderConfirmDeleteProductState state) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title:
              Text('Deseja excluir o produto ${state.product.product.name}?'),
          actions: [
            TextButton(
              onPressed: () => _cancelDeleteProduct(context),
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => _confirmDeleteProduct(context, state),
              child: Text('Confirmar', style: context.textStyles.textBold),
            ),
          ],
        ),
      );

  void _cancelDeleteProduct(BuildContext context) {
    Navigator.of(context).pop();
    controller.cancelDeleteProcess();
  }

  void _confirmDeleteProduct(
    BuildContext context,
    OrderConfirmDeleteProductState state,
  ) {
    Navigator.of(context).pop();
    controller.decrementProduct(state.index);
  }
}
