
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/constant/app_constant.dart';
import 'package:shop_now/model/address_model.dart';
import 'package:shop_now/model/cart_model.dart';
import 'package:shop_now/model/order_model.dart';
import 'package:shop_now/model/payment_model.dart';
import 'package:shop_now/provider/checkout_provider/checkout_state.dart';
import 'package:shop_now/repository/auth/auth_repo.dart';
import 'dart:math';

import 'package:shop_now/repository/order_repo/orderr_repo.dart';

final checkOutProvider = StateNotifierProvider<CheckOutNotifier, CheckOutState>(
    (ref) => CheckOutNotifier());

class CheckOutNotifier extends StateNotifier<CheckOutState> {
  CheckOutNotifier() : super(const CheckOutState()) {
    load();
  }

  AddressModel? addressModel;
  PaymentModel? paymentModel;

  load() async {
    checkOutButtonStatus();
  }

  void addOrder()  {

  }

  Future<String?> createOrder(
      List<CartModel> model, double totalPrice, String paymentMethod, double subTotal) async {

    final orderModel = OrderModel(
        id: Random().nextInt(1000).toString(),
        uid: AuthRepo().user.uid,
        items: model,
        deliveryAddress: addressModel!,
        paymentMethod: 'card',
        totalPrice: totalPrice.toString(),
        tax: AppConstant.taxes.toString(),
        deliveryFee: AppConstant.deliveryCharges.toString(),
        subTotal: subTotal.toString(),
        coupon: 0,
        createdAt: Timestamp.now());
    final result = await OrderRepo().createOrder(orderModel);
    return result;
  }

  void addAddress(AddressModel model) {
    addressModel = model;
    state =
        state.copyWith(addressModel: addressModel, paymentModel: paymentModel);
    checkOutButtonStatus();
  }

  void addPaymentMethod(PaymentModel model) {
    paymentModel = model;
    state =
        state.copyWith(paymentModel: paymentModel, addressModel: addressModel);
    checkOutButtonStatus();
  }

  void checkOutButtonStatus() {
    if (state.addressModel != null && state.paymentModel != null) {
      state = state.copyWith(
          disableCheckOutButton: false,
          paymentModel: paymentModel,
          addressModel: addressModel);
    }
  }

    void startLoader() {
        state = state.copyWith(isLoading: true);

  }

    void stopLoader() {
      state = state.copyWith(isLoading: false);

    }

}
