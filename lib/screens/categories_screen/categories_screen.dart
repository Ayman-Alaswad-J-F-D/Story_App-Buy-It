import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../app/cubit/app_cubit.dart';
import '../../theme/styles.dart';
import '../../widget/app_drawer_widget/custom_drawer.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/list_view_animation.dart';
import '../products_screen/components/product_fallback_conditional.dart';
import 'components/categories_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textTitle: 'Categories'),
      drawer: const CustomDrawer(),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.firstImagesAndCategories.isNotEmpty,
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Categories Product",
                    textAlign: TextAlign.center,
                    style: TextStyles.pacifico30PrimaryBold,
                  ),
                  const SizedBox(height: 70),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 65,
                      alignment: WrapAlignment.center,
                      children: List<Widget>.generate(
                        cubit.firstImagesAndCategories.length,
                        (index) => ListViewAnimation(
                          index: index,
                          flipAxis: FlipAxis.y,
                          child: CategoriesItem(
                            title: cubit.categories[index],
                            image: cubit.categoriesImages[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => ProductFallBackConditional(state: state),
          );
        },
      ),
    );
  }
}
