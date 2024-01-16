import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../theme/styles.dart';

class BillHeaderWidget extends StatelessWidget {
  const BillHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.zero,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      color: AppColors.secondPrimaryColor,
      surfaceTintColor: AppColors.secondPrimaryColor,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Ordere No", style: TextStyles.roboto14YallowRegularLS0_6),
            Text("Price", style: TextStyles.roboto14YallowRegularLS0_6),
            Text("Quantity", style: TextStyles.roboto14YallowRegularLS0_6),
            Text("Addition Time", style: TextStyles.roboto14YallowRegularLS0_6),
          ],
        ),
      ),
    );
  }
}
