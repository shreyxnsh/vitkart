import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
class DiscountContainer extends StatelessWidget {
  final String discount;

  const DiscountContainer({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        discount,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}