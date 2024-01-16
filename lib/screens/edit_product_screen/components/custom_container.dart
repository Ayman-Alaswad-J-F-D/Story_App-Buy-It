import 'package:flutter/material.dart';
import 'package:store_app/theme/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(8),
          left: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black26,
          )
        ],
      ),
      child: child,
    );
  }
}
