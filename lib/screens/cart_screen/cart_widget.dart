import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/provider/cart_provider/cart_provider.dart';
import 'package:shop_now/utils/app_color.dart';

import '../../model/cart_model.dart';
import '../../utils/text_builder.dart';

class CartCard extends ConsumerWidget {
  final CartModel cart;
  const CartCard({
    super.key,
    required this.cart,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    InkWell(
                      onTap: () {
                        ref.read(cartListProvider.notifier).removeItem(cart.id!);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    )
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
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              //provider.decreaseQuantity(cart.id!);
                              ref
                                  .read(cartListProvider.notifier)
                                  .decreaseQuantity(cart.id ?? 0);
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.black,
                            )),
                        TextBuilder(
                          text: cart.quantity.toString(),
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        IconButton(
                            onPressed: () {
                              // provider.increaseQuantity(cart.id!);
                              ref
                                  .read(cartListProvider.notifier)
                                  .increaseQuantity(cart.id ?? 0);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            ))
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
