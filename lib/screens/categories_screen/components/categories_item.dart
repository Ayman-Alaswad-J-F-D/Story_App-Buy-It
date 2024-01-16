import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/constants/constants.dart';
import '../../../app/extensions.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../categories_details_screen/categories_details_screen.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => context.toScreen(
        screen: CategoriesDetailsScreen(categoriesTitle: title),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            height: heightScreen(context) / 4.3,
            width: widthScreen(context) / 2.5,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  color: AppColors.lightPrimaryColor,
                  offset: Offset(-2, 2),
                ),
              ],
            ),
            child: Text(
              title.capitalize(),
              style: TextStyles.pacifico16WhiteRegular,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: -40,
            right: -5,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: AppColors.whiteColor,
              clipBehavior: Clip.antiAlias,
              surfaceTintColor: AppColors.whiteColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25, left: 28, right: 25),
                child: Transform.rotate(
                  angle: math.pi / 10.0,
                  child: Image(
                    image: NetworkImage(image),
                    width: widthScreen(context) / 5.5,
                    height: heightScreen(context) / 7,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
