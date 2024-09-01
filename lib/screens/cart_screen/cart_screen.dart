import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/constant/app_constant.dart';
import 'package:shop_now/provider/cart_provider/cart_provider.dart';
import 'package:shop_now/utils/app_bar/app_bar.dart';

import '../checkout_screen/check_out_screen.dart';
import '../product_details/add_to_cart_button.dart';
import 'cart_widget.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(cartListProvider).productList;
    final totalPrice = ref.watch(cartListProvider).totalPrice;
    final cartIsEmpty = ref.watch(cartListProvider).cartIsEmpty;
    final isLoading = ref.watch(cartListProvider).isLoading;

    return Scaffold(
      appBar: NormalAppBar(
        appBarTitle: AppConstant.cart,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : cartIsEmpty
                ? Center(child: Image.asset('assets/empty_cart.png'))
                : ListView.separated(
                    padding: const EdgeInsets.all(15),
                    itemCount: productList.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      return CartCard(cart: productList[i]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10.0);
                    },
                  ),
      ),
      bottomNavigationBar: cartIsEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddToCartButton(
                title: AppConstant.checkOut,
                subTitle: AppConstant.totalPrice,
                price: totalPrice,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CheckOutScreen()));
                },
              ),
            ),
    );
  }
}
