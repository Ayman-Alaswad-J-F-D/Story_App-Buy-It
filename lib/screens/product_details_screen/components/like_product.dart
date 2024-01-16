import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/app/cubit/app_cubit.dart';

import '../../../theme/colors.dart';

class LikeProduct extends StatefulWidget {
  final int id;
  final bool shadowTrue;
  final double height;
  final double sizeIcon;

  const LikeProduct({
    Key? key,
    required this.id,
    required this.shadowTrue,
    required this.height,
    required this.sizeIcon,
  }) : super(key: key);

  @override
  State<LikeProduct> createState() => _LikeProductState();
}

class _LikeProductState extends State<LikeProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        boxShadow: widget.shadowTrue
            ? const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 3,
                )
              ]
            : null,
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: AppColors.secondPrimaryColor),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Icon(
          AppCubit.get(context).cachedFavorite.contains(widget.id)
              ? FontAwesomeIcons.solidHeart
              : FontAwesomeIcons.heart,
          semanticLabel: 'Like',
          size: widget.sizeIcon,
          color: AppColors.iconLoveColor,
        ),
      ),
    );
  }
}
