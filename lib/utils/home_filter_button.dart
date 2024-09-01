
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/constant/app_constant.dart';
import 'package:shop_now/provider/product_list_provider/product_list_provider.dart';

import 'custom_model_bottom_sheet.dart';

class HomeFilterButton extends ConsumerWidget {
  const HomeFilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryArray =
        ref.read(productListProvider.notifier).getFilterList();
    final selectedCategory = ref.watch(productListProvider).filterCategory;
    return IconButton(
      onPressed: () {
        customModalBottomSheet(
          context,
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.separated(
            padding: const EdgeInsets.all(15),
            itemCount: categoryArray.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(categoryArray[i] ?? ''),
                onTap: () {
                  ref
                      .read(productListProvider.notifier)
                      .appliedFilter(categoryArray[i] ?? '');
                  Navigator.pop(context);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10.0);
            },
          ),
        );
      },
      icon: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 0),
            child: Icon(
              selectedCategory == AppConstant.allCategory
                  ? Icons.filter_alt_off
                  : Icons.filter_alt,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
