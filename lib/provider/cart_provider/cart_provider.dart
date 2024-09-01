import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/repository/storage/sql_service.dart';

import '../../model/cart_model.dart';
import 'cart_state.dart';

final cartListProvider = StateNotifierProvider<CartListNotifier, CartListState>(
    (ref) => CartListNotifier());

class CartListNotifier extends StateNotifier<CartListState> {
  CartListNotifier() : super(const CartListState()) {
    loadProducts();
  }

  SqlService cartServices = SqlService.instance;
  List<CartModel> cartItems = [];

  loadProducts() async {
    state = state.copyWith(isLoading: true);
    try {
      List<CartModel> list = await cartServices.getAll();
      print(list);
      cartItems.clear();
      cartItems = list;
      print(cartItems);
    } catch (e) {
      print(e);
    }

    state = state.copyWith(
        productList: cartItems,
        cartIsEmpty: cartItems.isEmpty ? true : false,
        totalPrice: getTotalCartPrice(),
        isLoading: false,
    );
  }

  void addItem(CartModel cartModel) async {
    int index = cartItems.indexWhere((item) => item.id == cartModel.id);
    if (index != -1) {
      // Item already exists, update quantity and price

      CartModel existingItem = cartItems[index];
      CartModel updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity! + cartModel.quantity!,
        totalPrice: existingItem.totalPrice! + cartModel.totalPrice!,
      );
      cartItems[index] = updatedItem;
      await cartServices.update(updatedItem);
    } else {
      // Item doesn't exist, add it to the list
      var result = await cartServices.insert(cartModel);
      cartItems.add(cartModel);
    }

    state = state.copyWith(
        productList: cartItems,
        cartIsEmpty: false,
        totalPrice: getTotalCartPrice());
  }

  void removeItem(int id) async {
    final cartList = cartItems;
    cartList.removeWhere((element) => element.id == id);
    await cartServices.delete(id);
    state = state.copyWith(
        productList: cartItems,
        totalPrice: getTotalCartPrice(),
        cartIsEmpty: cartItems.isEmpty ? true : false);
  }

  void clearCart() {
    state = state.copyWith(productList: [], cartIsEmpty: true);
  }

  void increaseQuantity(int id) async {
    final index = cartItems.indexWhere((e) => e.id == id);
    cartItems[index].quantity = cartItems[index].quantity! + 1;
    cartItems[index].totalPrice =
        cartItems[index].price! * cartItems[index].quantity!;
    await cartServices.update(cartItems[index]);
    state =
        state.copyWith(productList: cartItems, totalPrice: getTotalCartPrice());
  }

  Future<void> decreaseQuantity(int id) async {
    final cartList = cartItems;
    final index = cartList.indexWhere((e) => e.id == id);

    if (cartList[index].quantity! == 1) {
      removeItem(id);
      return;
    }

    if (cartList[index].quantity! > 1) {
      cartList[index].quantity = cartList[index].quantity! - 1;
      cartList[index].totalPrice =
          cartList[index].price! * cartList[index].quantity!;
      await cartServices.update(cartList[index]);
    }
    state = state.copyWith(
        productList: cartList,
        totalPrice: getTotalCartPrice(),
        cartIsEmpty: false);
  }

  double getTotalCartPrice() {
    return cartItems.fold(0.0, (t, e) => t + e.totalPrice!);
  }

  Future<void> deleteCartProduct() async {
    await cartServices.deleteAll();
    cartItems.clear();
    state = state.copyWith(productList: cartItems, cartIsEmpty: true);
  }
}
