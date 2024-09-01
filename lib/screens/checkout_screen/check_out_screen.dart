import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/model/payment_model.dart';
import 'package:shop_now/provider/checkout_provider/checkout_Provider.dart';
import 'package:shop_now/screens/cart_screen/address_form.dart';
import 'package:shop_now/screens/cart_screen/address_widget.dart';
import 'package:shop_now/screens/cart_screen/card_widget.dart';
import 'package:shop_now/screens/orders/order_accepted.dart';
import 'package:shop_now/utils/app_color.dart';

import '../../constant/app_constant.dart';
import '../../model/address_model.dart';
import '../../provider/cart_provider/cart_provider.dart';
import '../../utils/app_bar/app_bar.dart';
import '../../utils/custom_model_bottom_sheet.dart';
import '../../utils/text_builder.dart';
import 'check_out_product.dart';

class CheckOutScreen extends ConsumerWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.read(cartListProvider).productList;
    final totalPrice = ref.read(cartListProvider).totalPrice;
    final paymentModel = ref.watch(checkOutProvider).paymentModel;
    final addressModel = ref.watch(checkOutProvider).addressModel;
    final disbale = ref.watch(checkOutProvider).disableCheckOutButton ?? true;
    final isLoading = ref.watch(checkOutProvider).isLoading;

    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: NormalAppBar(
          appBarTitle: AppConstant.checkOut,
        ),
        body: SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(children: [
                    ListView.separated(
                      padding: const EdgeInsets.all(15),
                      itemCount: productList.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int i) {
                        return CheckOutProductCard(cart: productList[i]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10.0);
                      },
                    ),
                    const SizedBox(height: 15.0),
                    addressModel == null
                        ? checkoutRow(
                            ref: ref,
                            context: context,
                            AppConstant.addAddress,
                          )
                        : InkWell(
                            onTap: () {
                              customModalBottomSheet(
                                context,
                                height:
                                    MediaQuery.of(context).size.height * 0.92,
                                child: AddressForm(
                                  onSubmit: (AddressModel value) {
                                    ref
                                        .read(checkOutProvider.notifier)
                                        .addAddress(value);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                            child: AddressWidget(model: addressModel)),
                    getDivider(),
                    paymentModel == null
                        ? checkoutRow(
                            ref: ref,
                            context: context,
                            AppConstant.addCard,
                            trailingWidget: const Icon(
                              Icons.payment,
                            ),
                          )
                        : payment(paymentModel, context, ref),
                    getDivider(),
                    const SizedBox(height: 10.0),
                    totalWidget(
                      'Total Price',
                      trailingText: "\$${totalPrice.toStringAsFixed(2)}",
                    ),
                    totalWidget(
                      'Delivery Charge',
                      trailingText:
                          "\$${AppConstant.deliveryCharges.toStringAsFixed(2)}",
                    ),
                    totalWidget(
                      'Taxes',
                      trailingText: "\$${AppConstant.taxes.toStringAsFixed(2)}",
                    ),
                    totalWidget(
                      'Sub Total',
                      trailingText: "\$${getSubTotal(totalPrice)}",
                    ),
                    placeOrderButton(totalPrice, size, context, ref, disbale),
                  ]))));
  }
}

Widget getDivider() {
  return const Divider(
    thickness: 1,
    color: Color(0xFFE2E2E2),
  );
}

Widget checkoutRow(String label,
    {String? trailingText,
    Widget? trailingWidget,
    required BuildContext context,
    required WidgetRef ref}) {
  return InkWell(
      onTap: () {
        if (label == AppConstant.addAddress) {
          customModalBottomSheet(
            context,
            height: MediaQuery.of(context).size.height * 0.92,
            child: AddressForm(
              onSubmit: (AddressModel value) {
                ref.read(checkOutProvider.notifier).addAddress(value);
                Navigator.pop(context);
              },
            ),
          );
        } else {
          customModalBottomSheet(
            context,
            height: MediaQuery.of(context).size.height * 0.92,
            child: CardWidget(
              onSubmit: (String value) {
                final payment = PaymentModel(
                    token: 232424,
                    lastFourDigit: int.parse(value),
                    paymentId: 453353535,
                    paymentType: 'Card');
                ref.read(checkOutProvider.notifier).addPaymentMethod(payment);
                Navigator.pop(context);
              },
              dismiss: (value) {
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            TextBuilder(
              text: label,
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
            const Spacer(),
            trailingText == null
                ? (trailingWidget ?? Container())
                : TextBuilder(
                    text: trailingText,
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      ));
}

Widget payment(PaymentModel model, BuildContext context, WidgetRef ref) {
  return InkWell(
      onTap: () {
        customModalBottomSheet(
          context,
          height: MediaQuery.of(context).size.height * 0.92,
          child: CardWidget(
            onSubmit: (String value) {
              final payment = PaymentModel(
                  token: 232424,
                  lastFourDigit: int.parse(value),
                  paymentId: 453353535,
                  paymentType: 'Card');
              ref.read(checkOutProvider.notifier).addPaymentMethod(payment);
              Navigator.pop(context);
            },
            dismiss: (value) {
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            const Icon(
              Icons.payment,
              size: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            TextBuilder(
              text: '**** **** **** ${model.lastFourDigit}',
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ));
}

Widget termsAndConditionsAgreement(BuildContext context) {
  return RichText(
    text: const TextSpan(
        text: 'By placing an order you agree to our',
        style: TextStyle(
          color: Color(0xFF7C7C7C),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: " Terms",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          TextSpan(text: " And"),
          TextSpan(
            text: " Conditions",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
  );
}

Widget placeOrderButton(double total, Size size, BuildContext context,
    WidgetRef ref, bool disable) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: MaterialButton(
        height: 50,
        color: disable ? Colors.grey : AppColors.kBlue,
        minWidth: size.width * 0.8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () async {
          if (!disable) {
            ref.read(checkOutProvider.notifier).startLoader();
            final products = ref.read(cartListProvider).productList;
            final subtotal =
                total + AppConstant.deliveryCharges + AppConstant.taxes;
            final error = await ref
                .read(checkOutProvider.notifier)
                .createOrder(products, total, 'card', subtotal);
            ref.read(checkOutProvider.notifier).stopLoader();
            if (error == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const OrderAcceptedScreen()));
            } else {
              ToastMessage().showToast(context, error);
            }
          }
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Home()), (route) => false);
        },
        child: const TextBuilder(
          text: 'Place Order',
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
        ),
      ));
}

Widget totalWidget(String label,
    {String? trailingText, Widget? trailingWidget}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: Row(
      children: [
        TextBuilder(
          text: label,
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
        ),
        const Spacer(),
        trailingText == null
            ? (trailingWidget ?? Container())
            : TextBuilder(
                text: trailingText,
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              ),
      ],
    ),
  );
}

String getSubTotal(double totalPrice) {
  final total = totalPrice + AppConstant.deliveryCharges + AppConstant.taxes;
  return total.toStringAsFixed(2);
}

// void onPlaceOrderClicked() {
//   Navigator.pop(context);
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return OrderFailedDialogue();
//       });
// }
