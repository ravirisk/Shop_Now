import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/constant/app_constant.dart';
import 'package:shop_now/provider/cart_provider/cart_provider.dart';
import 'package:shop_now/screens/product_details/product_images_widget.dart';
import 'package:shop_now/screens/product_details/product_info_widget.dart';
import 'package:shop_now/screens/product_details/product_list_tile_widget.dart';
import 'package:shop_now/screens/product_details/product_return_widget.dart';
import 'package:shop_now/utils/cart_appbar_button.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../../utils/custom_model_bottom_sheet.dart';
import 'add_to_cart_button.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: AddToCartButton(
        price: productModel.price ?? 0.0,
        press: () {
          ref.read(cartListProvider.notifier).addItem(getCartModel(productModel));
          ToastMessage().showToast(context, AppConstant.productAddedToCart);
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              actions: const [
                CartAppbarButton(),
              ],
            ),
            ProductImages(
              images: [productModel.image ?? ''],
            ),
            ProductInfo(
              brand: productModel.category ?? '',
              title: productModel.title ?? '',
              isAvailable: true,
              description: productModel.description ?? '',
              rating: productModel.rating?.rate ?? 1,
              numOfReviews: productModel.rating?.count ?? 0,
            ),
            ProductListTile(
              svgSrc: "assets/icons/Return.svg",
              title: "Returns",
              isShowBottomBorder: true,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const ProductReturnsWidget(),
                );
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            )
          ],
        ),
      ),
    );

  }

  CartModel getCartModel(ProductModel model) {
   return  CartModel(
        id: productModel.id!,
        title: productModel.title!,
        price: productModel.price!,
        image: productModel.image!,
        category: productModel.category!,
        quantity: 1,
        totalPrice: productModel.price!);
  }
}
