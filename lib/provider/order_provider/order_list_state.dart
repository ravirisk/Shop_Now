import 'package:equatable/equatable.dart';
import 'package:shop_now/model/order_model.dart';

class OrderListState extends Equatable {
  final bool isLoading;
  final List<OrderModel> productList;

  const OrderListState({
    this.isLoading = false,
    this.productList = const [],
  });

  OrderListState copyWith({
    bool? isLoading,
    List<OrderModel>? productList,
  }) {
    return OrderListState(
      isLoading: isLoading ?? this.isLoading,
      productList: productList ?? this.productList,
    );
  }

  @override
  List<Object?> get props => [isLoading, productList];
}