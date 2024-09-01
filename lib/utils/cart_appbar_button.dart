import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/provider/cart_provider/cart_provider.dart';
import 'package:shop_now/screens/cart_screen/cart_screen.dart';
import 'package:shop_now/utils/text_builder.dart';

class CartAppbarButton extends ConsumerWidget {
  const CartAppbarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProductCount = ref.watch(cartListProvider).productList.length;
    return IconButton(
      onPressed: () {
         if (cartProductCount > 0) {
           Navigator.push(
               context, MaterialPageRoute(builder: (_) => const CartScreen()));
         }
      },
      icon: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: cartProductCount != 0 ? 8 : 0,
                right: cartProductCount != 0 ? 8 : 0),
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
              size: 30,
            ),
          ),
          if (cartProductCount != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                child: TextBuilder(
                  text: cartProductCount.toString(),
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
            )
        ],
      ),
    );
  }
}
