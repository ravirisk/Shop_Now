
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/provider/order_provider/order_provider.dart';
import 'package:shop_now/screens/orders/order_widget.dart';

import '../../constant/app_constant.dart';
import '../../utils/app_bar/app_bar.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.read(orderListProvider).productList;
    final isLoading = ref.watch(orderListProvider).isLoading;

    return Scaffold(
      appBar: NormalAppBar(appBarTitle: AppConstant.orders,),
      body: SafeArea(
        child: isLoading ? const Center(child: CircularProgressIndicator()): productList.isEmpty ? Center(
          child: Image.asset('assets/empty_cart.png'),
        ) : ListView.separated(
          padding: const EdgeInsets.all(15),
          itemCount: productList.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return OrderWidget(model: productList[i]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0);
          },
        ),
      ),
    ); }
}