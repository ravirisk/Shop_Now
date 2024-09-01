import 'package:flutter/material.dart';
import 'package:shop_now/constant/app_constant.dart';
import 'package:shop_now/model/address_model.dart';
import 'package:shop_now/model/cart_model.dart';
import 'package:shop_now/model/order_model.dart';

import '../../utils/app_color.dart';
import '../../utils/text_builder.dart';
import '../../utils/util_formater.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel model;
  const OrderWidget({
    super.key,
    required this.model,
  });
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const TextBuilder(
                          text: 'Processing',
                          fontSize: 12,
                          color: Colors.white,
                        )),
                    const Spacer(),
                    TextBuilder(
                      text: UtilFormatter.formatTimeStamp(model.createdAt),
                      color: AppColors.kBlue,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                TextBuilder(
                  text: '${AppConstant.orderId} : ${model.id}',
                  color: AppColors.kBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  maxLines: 3,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0),
                ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: model.items.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    return productsWidget( model.items[i]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10.0);
                  },
                ),
                totalWidget(
                  'Total Price',
                  trailingText: "\$${model.totalPrice}",
                ),
                getDivider(),
                totalWidget(
                  'Delivery Charge',
                  trailingText: "\$${model.deliveryFee}",
                ),
                getDivider(),
                totalWidget(
                  'Taxes',
                  trailingText: "\$${model.tax}",
                ),
                getDivider(),
                totalWidget(
                  'Sub Total',
                  trailingText: "\$${model.subTotal}",
                ),
                const SizedBox(height: 5),
                addressWidget(model.deliveryAddress),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget getDivider() {
  return const Divider(
    thickness: 1,
    color: AppColors.kBlue,
  );
}

Widget addressWidget(
  AddressModel model,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
    child: Row(
      children: [
        const Icon(
          Icons.home,
          size: 40,
        ),
        const SizedBox(
          width: 10,
        ),
        TextBuilder(
          text: '${AppConstant.delevierTo} ${model.streetAddress}',
          color: Colors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
        ),
      ],
    ),
  );
}

Widget productsWidget(
  CartModel model,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
    child: Row(
      children: [
        Image.network(
          model.image!,
          height: 50,
          width: 50,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextBuilder(
          text: '${model.title} X ${model.quantity}',
          color: AppColors.kBlue,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          maxLines: 3,
          textOverflow: TextOverflow.ellipsis,
        )),
      ],
    ),
  );
}

Widget totalWidget(String label,
    {String? trailingText, Widget? trailingWidget}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
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
      ],
    ),
  );
}
