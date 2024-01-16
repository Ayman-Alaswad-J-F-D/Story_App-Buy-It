import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app/cubit/app_cubit.dart';
import '../../theme/colors.dart';
import '../../widget/app_drawer_widget/custom_drawer.dart';
import '../../widget/custom_app_bar.dart';
import '../user_card_screen/user_card_screen.dart';
import 'components/product_fallback_conditional.dart';
import 'components/products_screen_body.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    AppCubit.get(context).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(
        textTitle: "New Trend",
        actionWidget: [
          BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              if (AppCubit.get(context).products.isEmpty) {
                return const SizedBox();
              }
              return IconButton(
                icon: const Icon(
                  FontAwesomeIcons.cartShopping,
                  color: AppColors.whiteColor,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserCardScreen(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        buildWhen: (previous, current) =>
            current is ProductsLoadingState ||
            current is ProductsSuccessState ||
            current is ProductsErrorState ||
            current is CheckConnectionState,
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition:
                state is ProductsSuccessState || cubit.products.isNotEmpty,
            builder: (context) {
              return RefreshIndicator(
                onRefresh: () async => cubit.refreshProducts(),
                color: AppColors.primaryColor,
                child: ProductsScreenBody(
                  productData: cubit.products,
                  categoryData: cubit.categories,
                ),
              );
            },
            fallback: (context) => ProductFallBackConditional(state: state),
          );
        },
      ),
    );
  }
}
