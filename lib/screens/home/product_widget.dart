import 'package:flutter/material.dart';
import 'package:shop_now/screens/product_details/product_details_screen.dart';
import 'package:shop_now/utils/app_color.dart';
import '../../model/product_model.dart';
import '../../utils/text_builder.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    //final cart = Provider.of<CartProvider>(context);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.kBlue, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(productModel: product)))
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  product.image!,
                  height: size.height,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  colorBlendMode: BlendMode.overlay,
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextBuilder(
                      text: product.title!,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.kBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextBuilder(
                          text: product.category,
                          fontSize: 12,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
