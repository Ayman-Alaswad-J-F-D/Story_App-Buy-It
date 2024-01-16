import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../theme/colors.dart';
import '../../../widget/custom_rating.dart';
import 'like_product.dart';

class ProductLikeAndRating extends StatelessWidget {
  const ProductLikeAndRating({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          LikeProduct(
            id: product.id,
            shadowTrue: true,
            height: 40,
            sizeIcon: 18,
          ),
          const SizedBox(width: 25),
          Expanded(
            child: CustomRating(
              rate: product.rating!.rate,
              colorValueLable: AppColors.secondPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
