import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constants/constants.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';

class TotalPriceWidget extends StatelessWidget {
  const TotalPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: heightScreen(context) * .11),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      color: AppColors.secondPrimaryColor,
      surfaceTintColor: AppColors.secondPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Price",
              style: TextStyles.roboto14YallowRegularLS0_6,
            ),
            BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) => Text(
                "\$ ${AppCubit.get(context).totalPrice}",
                style: TextStyles.roboto14YallowRegularLS0_6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
