import 'package:flutter/material.dart';
import 'package:store_app/app/constants/constants.dart';
import 'package:store_app/theme/styles.dart';

import '../../../models/product_model.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRichText(label: "Name Product", sub: product.title),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: CustomRichText(
                        label: "Price",
                        sub: "\$ ${product.price.toString()}",
                      ),
                    ),
                    const SizedBox(height: 30),
                    Flexible(
                      child: CustomRichText(
                        label: "Quantity",
                        sub: product.rating!.count.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 2,
                child: Image.network(
                  product.image,
                  height: heightScreen(context) / 3.8,
                  width: widthScreen(context) / 3.5,
                  errorBuilder: (context, object, stackTrack) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    Key? key,
    required this.label,
    required this.sub,
  }) : super(key: key);

  final String label;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: "$label\n", style: TextStyles.pacifico15GrayRegular),
          TextSpan(
            text: sub,
            style: TextStyles.font15SecondPrimaryBold.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
