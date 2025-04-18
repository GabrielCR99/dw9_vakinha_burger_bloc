import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/extensions/formatter_extension.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/styles/app_colors.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/delivery_app_bar.dart';
import '../../core/ui/widgets/delivery_button.dart';
import '../../core/ui/widgets/delivery_increment_decrement_button.dart';
import '../../dto/order_product_dto.dart';
import '../../models/payment_type_model.dart';
import 'controller/order_controller.dart';
import 'widgets/payment_types_field.dart';

part 'widgets/__order_field.dart';
part 'widgets/__order_product_tile.dart';

final class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

final class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final _formKey = GlobalKey<FormState>();
  final _addressEC = TextEditingController();
  final _documentEC = TextEditingController();
  final _paymentTypeValid = ValueNotifier(true);
  final _cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  int? _paymentTypeId;

  @override
  void onReady() {
    super.onReady();
    final products =
        ModalRoute.of(context)!.settings.arguments! as List<OrderProductDto>;
    controller.load(products);
  }

  void _orderListener(BuildContext context, OrderState state) {
    switch (state.status) {
      case OrderStatus.initial:
      case OrderStatus.loaded:
        hideLoader();
      case OrderStatus.updatedOrder:
        break;
      case OrderStatus.loading:
        showLoader();
      case OrderStatus.error:
        hideLoader();
        showError(state.errorMessage!);
      case OrderStatus.success:
        hideLoader();
        showSuccess('Pedido realizado com sucesso');
        Navigator.of(context).popAndPushNamed<void, List<OrderProductDto>>(
          '/order/completed',
          result: const [],
        );
      case OrderStatus.confirmDeleteProduct:
        hideLoader();
        if (state is OrderConfirmDeleteProductState) {
          _showConfirmDeleteProduct(state);
        }
      case OrderStatus.emptyBag:
        showInfo('Sua sacola está vazia! Adicione produtos para continuar.');
        Navigator.of(context).pop<List<OrderProductDto>>(const []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: _orderListener,
      child: PopScope(
        onPopInvokedWithResult:
            (_, __) => Navigator.of(context).pop(controller.state.products),
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
                        Text('Carrinho', style: context.textStyles.textTitle),
                        IconButton(
                          onPressed: controller.emptyBag,
                          icon: Image.asset('assets/images/trashRegular.png'),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocSelector<
                  OrderController,
                  OrderState,
                  List<OrderProductDto>
                >(
                  selector: (state) => state.products,
                  builder:
                      (_, state) => SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) => Column(
                            children: [
                              _OrderProductTile(
                                index: index,
                                orderProduct: state[index],
                              ),
                              const Divider(color: Colors.grey),
                            ],
                          ),
                          childCount: state.length,
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
                              style: context.textStyles.textExtraBold.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder:
                                  (_, totalOrder) => Text(
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
                      _OrderField(
                        title: 'Endereço de entrega',
                        controller: _addressEC,
                        validator: Validatorless.required(
                          'Endereço obrigatório',
                        ),
                        hintText: 'Digite um endereço',
                      ),
                      const SizedBox(height: 10),
                      _OrderField(
                        title: 'Cpf',
                        controller: _documentEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Cpf obrigatório'),
                          Validatorless.cpf('Cpf inválido'),
                        ]),
                        hintText: 'Digite o cpf',
                        inputFormatters: [_cpfMask],
                      ),
                      const SizedBox(height: 20),
                      BlocSelector<
                        OrderController,
                        OrderState,
                        List<PaymentTypeModel>
                      >(
                        selector: (state) => state.payments,
                        builder:
                            (_, payments) => ValueListenableBuilder(
                              valueListenable: _paymentTypeValid,
                              builder:
                                  (_, paymentTypeValidValue, __) =>
                                      PaymentTypesField(
                                        payments: payments,
                                        onChanged:
                                            (value) => _paymentTypeId = value,
                                        valid: paymentTypeValidValue,
                                        selectedValue: '$_paymentTypeId',
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
                          onPressed: _onPressedFinish,
                          height: 48,
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

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _addressEC.dispose();
    _documentEC.dispose();
    super.dispose();
  }

  void _onPressedFinish() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final hasSelectedPaymentType = _paymentTypeId != null;
    _paymentTypeValid.value = hasSelectedPaymentType;

    if (formValid && hasSelectedPaymentType) {
      controller.saveOrder(
        address: _addressEC.text,
        document: _documentEC.text,
        paymentMethodId: _paymentTypeId!,
      );
    }
  }

  void _showConfirmDeleteProduct(OrderConfirmDeleteProductState state) =>
      showDialog<void>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(
                'Deseja excluir o produto ${state.product.product.name}?',
              ),
              actions: [
                TextButton(
                  onPressed: () => _cancelDeleteProduct(context),
                  child: Text(
                    'Cancelar',
                    style: context.textStyles.textBold.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _confirmDeleteProduct(context, state),
                  child: Text('Confirmar', style: context.textStyles.textBold),
                ),
              ],
            ),
        barrierDismissible: false,
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
