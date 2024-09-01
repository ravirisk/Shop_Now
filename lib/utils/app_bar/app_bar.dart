import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/utils/cart_appbar_button.dart';
import '../app_color.dart';
import '../home_filter_button.dart';
import '../text_builder.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.appBarTitle,
  });

  final String appBarTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size preferredSize = const Size.fromHeight(kToolbarHeight);

    return PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          centerTitle: true,
          title: TextBuilder(
              text: appBarTitle,
              color: AppColors.kBlue,
              fontSize: 20,
              fontWeight: FontWeight.w700),
          actions: const [HomeFilterButton(),CartAppbarButton()],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NormalAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const NormalAppBar({
    super.key,
    required this.appBarTitle,
  });

  final String appBarTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size preferredSize = const Size.fromHeight(kToolbarHeight);

    return PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          centerTitle: true,
          title: TextBuilder(
              text: appBarTitle,
              color: AppColors.kBlue,
              fontSize: 20,
              fontWeight: FontWeight.w700),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Manually pop the current screen
            },
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
