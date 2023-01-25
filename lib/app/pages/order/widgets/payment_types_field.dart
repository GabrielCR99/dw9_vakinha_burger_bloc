import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';

class PaymentTypesField extends StatelessWidget {
  final List<PaymentTypeModel> payments;
  final ValueChanged<int> onChanged;
  final bool valid;
  final String selectedValue;

  const PaymentTypesField({
    required this.payments,
    required this.onChanged,
    required this.valid,
    required this.selectedValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forma de pagamento',
            style: context.textStyles.textRegular.copyWith(fontSize: 16),
          ),
          SmartSelect.single(
            title: '',
            groupCounter: false,
            selectedValue: selectedValue,
            modalType: S2ModalType.bottomSheet,
            onChange: (value) => onChanged(int.parse(value.value)),
            tileBuilder: (context, state) => InkWell(
              onTap: state.showModal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: context.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.selected.title ?? '',
                          style: context.textStyles.textRegular,
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                  if (valid) const SizedBox.shrink() else const Divider(),
                  if (valid)
                    const SizedBox.shrink()
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Selecione uma forma de pagamento',
                        style: context.textStyles.textRegular
                            .copyWith(fontSize: 13, color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
            choiceItems: S2Choice.listFrom(
              source: payments
                  .map((e) => {'value': '${e.id}', 'title': e.name})
                  .toList(),
              title: (_, item) => item['title'] ?? '',
              value: (_, item) => item['value'] ?? '',
              group: (_, item) => 'Selecione uma forma de pagamento',
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false,
            placeholder: '',
          ),
        ],
      ),
    );
  }
}
