
import 'package:flutter/material.dart';

import '../../model/cart_model.dart';
import '../../utils/app_color.dart';
import '../../utils/text_builder.dart';

class CheckOutProductCard extends StatelessWidget {
  final CartModel cart;
  const CheckOutProductCard({
    super.key,
    required this.cart,
  });
  @override
  Widget build(BuildContext context,) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.network(
            cart.image!,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextBuilder(
                        text: '${cart.title} X ${cart.quantity}',
                        color: AppColors.kBlue,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                const SizedBox(height: 10.0),
                Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextBuilder(
                      text: cart.category,
                      fontSize: 12,
                      color: Colors.white,
                    )),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        TextBuilder(
                          text: cart.quantity.toString(),
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const TextBuilder(
                            text: 'Total: ',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                          TextBuilder(
                            text:  "\$${cart.price?.toStringAsFixed(2)}",
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}