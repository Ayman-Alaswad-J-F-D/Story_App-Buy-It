import 'package:flutter/material.dart';
import 'package:store_app/screens/products_screen/components/product_card.dart';

import '../../../app/constants/constants.dart';
import '../../../models/product_model.dart';
import '../../../widget/grid_view_animation.dart';
import '../../../widget/list_view_animation.dart';
import 'category_widget.dart';
import 'grid_view_helper.dart';

class ProductsScreenBody extends StatelessWidget {
  const ProductsScreenBody({
    Key? key,
    required this.productData,
    required this.categoryData,
  }) : super(key: key);

  final List<ProductModel> productData;
  final List<String> categoryData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(
                  categoryData.length,
                  (index) => ListViewAnimation(
                    index: index,
                    verticalOffset: -80,
                    child: CategoryWidget(
                      categoryData: categoryData,
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
            GridView.count(
              padding: EdgeInsets.only(
                top: heightScreen(context) * .13,
                left: 6,
                right: 6,
                bottom: 20,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: GridHelper.flexibleCrossAxisCount(context),
              childAspectRatio: GridHelper.flexibleAspectRatio(context),
              crossAxisSpacing: 5,
              mainAxisSpacing: 95,
              children: List<Widget>.generate(
                productData.length,
                (index) => GridViewAnimation(
                  index: index,
                  child: ProductCard(product: productData[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
