
import 'package:flutter/material.dart';
import 'package:shop_now/utils/text_builder.dart';

import 'app_color.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBuilder(text: 'SHOP ', color: AppColors.kBlue, fontSize: 30, fontWeight: FontWeight.w700),
        TextBuilder(text: 'NOW', color: Colors.green, fontSize: 30),
      ],
    );
  }
}