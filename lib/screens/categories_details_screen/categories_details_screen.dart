import 'package:flutter/material.dart';

import '../../app/cubit/app_cubit.dart';
import '../../app/extensions.dart';
import '../../theme/colors.dart';
import '../../widget/custom_app_bar.dart';
import 'components/categories_details_body.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  const CategoriesDetailsScreen({
    Key? key,
    required this.categoriesTitle,
  }) : super(key: key);

  final String categoriesTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(textTitle: categoriesTitle.capitalize()),
      body: CategoriesDetailsBody(
        products: AppCubit.get(context)
            .products
            .where((product) => product.category == categoriesTitle)
            .toList(),
      ),
    );
  }
}
