import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_now/model/address_model.dart';
import 'cart_model.dart';

class OrderModel extends Equatable {
  final String id;
  final String uid;
  final List<CartModel> items;
  final String paymentMethod;
  final AddressModel deliveryAddress;
  final String totalPrice;
  final String tax;
  final String deliveryFee;
  final String subTotal;
  final int coupon;
  final Timestamp createdAt;

  bool get isDelivering {
    var now = Timestamp.now();
    return now.compareTo(receivedDate) < 0;
  }

  Timestamp get receivedDate =>
      Timestamp.fromDate(this.createdAt.toDate().add( Duration(days: 3)));

  OrderModel({
    required this.id,
    required this.uid,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.totalPrice,
    required this.tax,
    required this.deliveryFee,
    required this.subTotal,
    required this.coupon,
    required this.createdAt,
  });

  /// Json data from server turns into model data
  static OrderModel fromMap(Map<String, dynamic> data) {
    return OrderModel(
      id: data["id"],
      uid: data["uid"],
      items: List<CartModel>.from(data["items"]!.map((item) {
        return CartModel.fromJson(item);
      })),
      deliveryAddress: AddressModel.fromJson(data["deliveryAddress"]),
      paymentMethod: data["paymentMethod"],
      totalPrice: data["totalPrice"],
      tax: data["tax"],
      deliveryFee: data["deliveryFee"],
      subTotal: data["subTotal"],
      coupon: data["coupon"],
      createdAt: data["createdAt"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "items": List<dynamic>.from(items.map((item) => item.toJson())),
      "deliveryAddress": deliveryAddress.toJson(),
      "paymentMethod": paymentMethod,
      "totalPrice": totalPrice,
      "tax": tax,
      "deliveryFee": deliveryFee,
      "subTotal" : subTotal,
      "coupon": coupon,
      "createdAt": createdAt,
    };
  }

  OrderModel copyWith({
    id,
    uid,
    items,
    deliveryAddress,
    paymentMethod,
    totalPrice,
    tax,
    priceOfGoods,
    deliveryFee,
    subTotal,
    coupon,
    createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      items: items ?? this.items,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalPrice: totalPrice ?? this.totalPrice,
      tax: tax ?? this.tax,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subTotal: subTotal ?? this.subTotal,
      coupon: coupon ?? this.coupon,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    uid,
    items,
    deliveryAddress,
    paymentMethod,
    tax,
    deliveryFee,
    subTotal,
    coupon,
    createdAt,
    totalPrice
  ];
}
