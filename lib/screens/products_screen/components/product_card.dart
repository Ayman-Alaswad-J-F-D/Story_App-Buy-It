import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../app/extensions.dart';
import '../../../models/product_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../../widget/custom_rating.dart';
import '../../product_details_screen/product_details_screen.dart';
import 'custom_image_network.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => context.toScreen(
        screen: ProductDetailsScreen(product: product),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 2,
            color: AppColors.whiteColor,
            surfaceTintColor: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font14LightPrimaryRegular,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ${product.price}',
                          style: TextStyles.font15SecondPrimaryRegular,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => cubit.changeFavorites(product.id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 4,
                            ),
                            child: BlocBuilder<AppCubit, AppStates>(
                              buildWhen: (previous, current) =>
                                  current is ChangeFavoriteState,
                              builder: (context, state) => Icon(
                                cubit.cachedFavorite.contains(product.id)
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomRating(rate: product.rating!.rate),
                ],
              ),
            ),
          ),
          CustomImageNetwork(product: product),
          Positioned(
            top: 4,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: AppColors.secondPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  product.id.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyles.pacifico12YallowRegular,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
