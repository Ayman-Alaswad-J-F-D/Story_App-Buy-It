import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/theme/colors.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      left: 20,
      top: -70,
      child: Image.network(
        product.image,
        height: MediaQuery.of(context).size.height * 0.125,
        // width: MediaQuery.of(context).size.width * .25,
        fit: BoxFit.contain,
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stackTrace,
        ) {
          return const Center(
            heightFactor: 2,
            child: CircularProgressIndicator(
              color: AppColors.secondPrimaryColor,
            ),
          );
        },
      ),
    );
  }
}
