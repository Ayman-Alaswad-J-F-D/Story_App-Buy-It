import 'package:flutter/material.dart';
import 'package:store_app/theme/colors.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
    required this.icon,
    this.color = AppColors.whiteColor,
    this.iconSize = 20,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final double iconSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color, size: iconSize),
      onPressed: onPressed,
    );
  }
}
