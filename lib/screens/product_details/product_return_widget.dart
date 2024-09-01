import 'package:flutter/material.dart';
import 'package:shop_now/constant/app_constant.dart';


class ProductReturnsWidget extends StatelessWidget {
  const ProductReturnsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16 / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    "Return",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
              AppConstant.returnDes
              ),
            )
          ],
        ),
      ),
    );
  }
}
