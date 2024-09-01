import 'package:shop_now/model/address_model.dart';
import 'package:shop_now/model/payment_model.dart';

import 'package:equatable/equatable.dart';

class CheckOutState extends Equatable {
  final bool? disableCheckOutButton;
  final AddressModel? addressModel;
  final PaymentModel? paymentModel;
  final bool isLoading;

  const CheckOutState({
    this.disableCheckOutButton = true,
    this.addressModel,
    this.paymentModel,
    this.isLoading = false
  });

  CheckOutState copyWith({
    bool? disableCheckOutButton,
    AddressModel? addressModel,
    PaymentModel? paymentModel,
    bool? isLoading
  }) {
    return CheckOutState(
      disableCheckOutButton: disableCheckOutButton ?? this.disableCheckOutButton,
      addressModel: addressModel ?? addressModel,
        paymentModel: paymentModel ?? paymentModel,
      isLoading: isLoading ?? this.isLoading
    );
  }

  @override
  List<Object?> get props => [disableCheckOutButton, addressModel, paymentModel];
}
