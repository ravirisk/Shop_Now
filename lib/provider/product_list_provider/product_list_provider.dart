import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/model/product_model.dart';
import 'package:shop_now/provider/product_list_provider/product_list_state.dart';
import '../../constant/app_constant.dart';
import '../../repository/product_list_repo/product_list_repo.dart';

final productListProvider =
    StateNotifierProvider<ProductListNotifier, ProductListState>(
        (ref) => ProductListNotifier());

class ProductListNotifier extends StateNotifier<ProductListState> {
  ProductListNotifier() : super(const ProductListState()) {
    loadProducts();
  }

  List<ProductModel> productItems = [];

  loadProducts() async {
    productItems.clear();
    state = state.copyWith(isLoading: true);
    final productList = await ProductListRepo().fetchProducts();
    productItems = productList;
    // Update state in provider
    state = state.copyWith(
      productList: productList,
      isLoading: false,
    );
  }

  appliedFilter(String category) async {
    if (category == AppConstant.allCategory) {
      state = state.copyWith(
        productList: productItems,
        isLoading: false,
        filterCategory: AppConstant.allCategory,
      );

      return;
    }

    final filterList =
        productItems.where((p) => p.category == category).toList();
    state = state.copyWith(
      productList: filterList,
      isLoading: false,
      filterCategory: category == AppConstant.allCategory
          ? AppConstant.allCategory
          : category,
    );
  }

  List<String?> getFilterList() {
    if (productItems.isNotEmpty) {
      final categoryArray = productItems.map((e) => e.category).toList();
      categoryArray.add(AppConstant.allCategory);
      return categoryArray.toSet().toList();
    }
    return [];
  }
}
