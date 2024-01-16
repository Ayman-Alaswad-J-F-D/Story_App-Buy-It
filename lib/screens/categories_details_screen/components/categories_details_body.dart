import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../app/constants/constants.dart';
import '../../../app/extensions.dart';
import '../../../models/product_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../../widget/list_view_animation.dart';
import '../../product_details_screen/product_details_screen.dart';

class CategoriesDetailsBody extends StatelessWidget {
  const CategoriesDetailsBody({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: products.length,
      itemBuilder: (context, index) => InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => context.toScreen(
          screen: ProductDetailsScreen(
            product: products[index],
          ),
        ),
        child: ListViewAnimation(
          index: index,
          flipAxis: FlipAxis.y,
          horizontalOffset: 150,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.13,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whiteColor,
              boxShadow: const [
                BoxShadow(blurRadius: 5, color: Colors.black45)
              ],
            ),
            child: Center(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: Image.network(
                  products[index].image,
                  width: widthScreen(context) * 0.25,
                  errorBuilder: (context, error, stackTrace) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                title: Text(
                  products[index].title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font16PrimaryRegular,
                ),
                trailing: Text(
                  "\$ ${products[index].price}",
                  textAlign: TextAlign.center,
                  style: TextStyles.font15SecondPrimaryBold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
