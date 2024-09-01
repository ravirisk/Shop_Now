import 'package:flutter/material.dart';
import 'package:shop_now/utils/text_builder.dart';


Future<dynamic> customModalBottomSheet(
    BuildContext context, {
      bool isDismissible = true,
      double? height,
      required Widget child,
    }) {
  return showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12 * 2),
        topRight: Radius.circular(12 * 2),
      ),
    ),
    builder: (context) => SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.75,
      child: child,
    ),
  );
}

class ToastMessage {

  void showToast(BuildContext context, String title) {
    final ScaffoldMessengerState buyNow = ScaffoldMessenger.of(context);
    buyNow.showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        content:  TextBuilder(text: title),
      ),
    );
  }
}




