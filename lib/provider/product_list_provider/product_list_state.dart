
import '../../model/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductListState extends Equatable {
  final bool isLoading;
  final List<ProductModel> productList;
  final String filterCategory;

  const ProductListState({
    this.isLoading = false,
    this.productList = const [],
    this.filterCategory = 'All',
  });

  ProductListState copyWith({
    bool? isLoading,
    List<ProductModel>? productList,
    String? filterCategory,
  }) {
    return ProductListState(
      isLoading: isLoading ?? this.isLoading,
      productList: productList ?? this.productList,
      filterCategory: filterCategory ?? this.filterCategory,
    );
  }

  @override
  List<Object?> get props => [isLoading, productList, filterCategory];
}
