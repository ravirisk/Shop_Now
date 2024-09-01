import 'package:flutter/material.dart';
import 'package:shop_now/model/address_model.dart';
import '../../utils/text_builder.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel model;

  const AddressWidget({
    super.key,
    required this.model,
  });
  @override
  Widget build(BuildContext context,) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2), child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.home,
            size: 40,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextBuilder(
                        text: '${model.streetAddress}',
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                const SizedBox(height: 2),
                Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                    child: TextBuilder(
                      text: model.state,
                      fontSize: 15,
                      color: Colors.black,
                    )),
                const SizedBox(height: 2),
                Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                    child: TextBuilder(
                      text: model.country,
                      fontSize: 15,
                      color: Colors.black,
                    )),
                const SizedBox(height: 2),
                Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                    child: TextBuilder(
                      text: model.postalCode.toString(),
                      fontSize: 15,
                      color: Colors.black,
                    )),

              ],
            ),
          )
        ],
      ),
    ));
  }
}