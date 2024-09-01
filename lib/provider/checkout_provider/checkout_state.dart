import 'package:shop_now/model/address_model.dart';
import 'package:shop_now/model/payment_model.dart';

import 'package:equatable/equatable.dart';

class CheckOutState extends Equatable {
  final bool? disableCheckOutButton;
  final AddressModel? addressModel;
  final PaymentModel? paymentModel;

  const CheckOutState({
    this.disableCheckOutButton = true,
    this.addressModel,
    this.paymentModel,
  });

  CheckOutState copyWith({
    bool? disableCheckOutButton,
    AddressModel? addressModel,
    PaymentModel? paymentModel,
  }) {
    return CheckOutState(
      disableCheckOutButton: disableCheckOutButton ?? this.disableCheckOutButton,
      addressModel: addressModel ?? addressModel,
        paymentModel: paymentModel ?? paymentModel
    );
  }

  @override
  List<Object?> get props => [disableCheckOutButton, addressModel, paymentModel];
}
