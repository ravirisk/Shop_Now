import 'package:flutter/material.dart';
import 'package:shop_now/constant/app_constant.dart';
import 'package:shop_now/utils/app_color.dart';

import '../../utils/text_builder.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.favorite_border,
            color: AppColors.kBlue,
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5), child:
          MaterialButton(
            height: 60,
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () {
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Home()), (route) => false);
            },
            child:  TextBuilder(
              text: AppConstant.addToCart,
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          )),
        ],
      ),
    );
  }
}