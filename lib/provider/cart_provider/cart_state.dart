import 'package:equatable/equatable.dart';
import 'package:shop_now/model/cart_model.dart';

class CartListState extends Equatable {
  final List<CartModel> productList;
  final bool cartIsEmpty;
  final double totalPrice;
  final bool isLoading;

  const CartListState({
    this.productList = const [],
    this.cartIsEmpty = true,
    this.totalPrice = 0.0,
    this.isLoading = true,
  });

  CartListState copyWith({
    List<CartModel>? productList,
    bool? cartIsEmpty,
    double? totalPrice,
    bool? isLoading
  }) {
    return CartListState(
      productList: productList ?? this.productList,
      cartIsEmpty:  cartIsEmpty ?? this.cartIsEmpty,
      totalPrice:  totalPrice ?? this.totalPrice,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [productList, cartIsEmpty , totalPrice, isLoading];
}
