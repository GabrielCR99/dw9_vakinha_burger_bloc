import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  final int amount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool _compact;

  const DeliveryIncrementDecrementButton({
    required this.amount,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  }) : _compact = false;

  const DeliveryIncrementDecrementButton.compact({
    required this.amount,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  }) : _compact = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compact ? const EdgeInsets.all(5) : null,
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onDecrement,
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '-',
                style: context.textStyles.textMedium.copyWith(
                  fontSize: _compact ? 10 : 22,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Text(
            '$amount',
            style: context.textStyles.textRegular.copyWith(
              fontSize: _compact ? 13 : 17,
              color: context.appColors.secondary,
            ),
          ),
          InkWell(
            onTap: onIncrement,
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '+',
                style: context.textStyles.textRegular.copyWith(
                  fontSize: _compact ? 10 : 22,
                  color: context.appColors.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
