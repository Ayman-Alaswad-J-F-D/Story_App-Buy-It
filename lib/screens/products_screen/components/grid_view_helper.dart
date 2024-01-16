import 'package:flutter/material.dart';

import '../../../app/constants/constants.dart';
import '../../../app/responsive.dart';

class GridHelper {
  static int flexibleCrossAxisCount(BuildContext context) {
    return Responsive.isDesktop(context)
        ? 4
        : Responsive.isMobileLarge(context)
            ? 3
            : Responsive.isMobile(context)
                ? 2
                : 1;
  }

  static double flexibleAspectRatio(BuildContext context) {
    return widthScreen(context) > 1080
        ? 1.45
        : widthScreen(context) > 700
            ? 1.3
            : Responsive.isMobile(context)
                ? 1
                : widthScreen(context) > 300
                    ? 1.4
                    : 1.5;
  }
}
