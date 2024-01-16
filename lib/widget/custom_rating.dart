import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../theme/colors.dart';

class CustomRating extends StatelessWidget {
  const CustomRating({
    Key? key,
    required this.rate,
    this.colorValueLable = AppColors.primaryColor,
  }) : super(key: key);

  final num rate;
  final Color colorValueLable;

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      value: double.parse(rate.toString()),
      maxValueVisibility: false,
      valueLabelPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      valueLabelRadius: 5,
      valueLabelColor: colorValueLable,
      starCount: 5,
      starSpacing: 0.5,
      starColor: Colors.amber,
      starBuilder: (index, color) => Icon(
        Icons.star_sharp,
        color: color,
        size: 18,
      ),
      // onValueChanged: (v) {
      //   setState(() {
      //     widget.rate = v;
      //   });
      // },
    );
  }
}
