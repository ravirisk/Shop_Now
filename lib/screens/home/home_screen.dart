import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/constant/app_constant.dart';
import 'package:shop_now/screens/hamburger_menu/hamburger_menu.dart';
import 'package:shop_now/screens/home/product_widget.dart';
import 'package:shop_now/utils/app_bar/app_bar.dart';
import '../../provider/product_list_provider/product_list_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productListProvider).productList;
    final isLoading = ref.watch(productListProvider).isLoading;

    return Scaffold(
      drawer: const HamburgerMenu(),
      appBar: CustomAppBar(appBarTitle: AppConstant.homeScreen),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5 / 4,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: productList.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  return ProductCard(product: productList[i]);
                },
              ),
      ),
    );
  }
}
