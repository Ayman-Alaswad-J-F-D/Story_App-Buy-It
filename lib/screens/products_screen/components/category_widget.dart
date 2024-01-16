import 'package:flutter/material.dart';

import '../../../app/extensions.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../categories_details_screen/categories_details_screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.categoryData,
    required this.index,
  }) : super(key: key);

  final List<String> categoryData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.toScreen(
          screen: CategoriesDetailsScreen(
            categoriesTitle: categoryData[index],
          ),
        ),
        child: Card(
          elevation: 2,
          color: AppColors.secondPrimaryColor,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          surfaceTintColor: AppColors.secondPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              widthFactor: 1.2,
              child: Text(
                categoryData[index].capitalize(),
                style: TextStyles.roboto14YallowRegularLS0_6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
