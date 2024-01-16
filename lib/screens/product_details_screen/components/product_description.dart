import 'package:flutter/material.dart';
import 'package:store_app/app/constants/constants.dart';
import 'package:store_app/screens/product_details_screen/components/product_like_and_rating.dart';
import 'package:store_app/theme/styles.dart';

import '../../../models/product_model.dart';
import '../../../theme/colors.dart';
import 'read_more_text.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightScreen(context) * .7,
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 70,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          SizedBox(
            height: 15,
            width: double.infinity,
            child: OverflowBox(
              maxHeight: 100,
              maxWidth: widthScreen(context),
              alignment: Alignment.bottomCenter,
              child: ProductLikeAndRating(product: product),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Description",
                  style: TextStyles.pacifico17WhiteRegularLS0_5,
                ),
                const SizedBox(height: 10),
                ReadMoreText(
                  text: product.description,
                  sizeHeight: heightScreen(context),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
