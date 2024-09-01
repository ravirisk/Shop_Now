import 'package:flutter/material.dart';
import 'package:shop_now/utils/app_color.dart';

class ProductAvailabilityTag extends StatelessWidget {
  const ProductAvailabilityTag({
    super.key,
    required this.isAvailable,
  });

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16 / 2),
      decoration: BoxDecoration(
        color: isAvailable ? AppColors.successColor : AppColors.errorColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0 / 2),
        ),
      ),
      child: Text(
        isAvailable ? "Available in stock" : "Currently unavailable",
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
