import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/order_repo/orderr_repo.dart';
import 'order_list_state.dart';

final orderListProvider =
StateNotifierProvider<OrderListNotifier, OrderListState>(
        (ref) => OrderListNotifier());

class OrderListNotifier extends StateNotifier<OrderListState> {
  OrderListNotifier() : super(const OrderListState()) {
    loadProducts();
  }

  loadProducts() async {
    state = state.copyWith(isLoading: true);
    final productList = await OrderRepo().fetchOrders();
    // Update state in provider
    state = state.copyWith(productList: productList, isLoading: false);
  }
}
