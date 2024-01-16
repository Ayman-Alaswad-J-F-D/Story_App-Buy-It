import 'package:flutter/material.dart';
import 'package:store_app/app/cubit/app_cubit.dart';

import '../../../app/extensions.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../../widget/custom_button.dart';
import '../../edit_product_screen/edit_product_screen.dart';

class UserCardBottomSheet extends StatelessWidget {
  const UserCardBottomSheet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: cubit.cardUser.isNotEmpty
          ? Container(
              color: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Order Products",
                      backgroundColor: AppColors.secondPrimaryColor,
                      colorText: AppColors.whiteColor,
                      // TODo:
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      icon: const Icon(Icons.edit, color: AppColors.whiteColor),
                      label: const Text(
                        "Edit Products",
                        style: TextStyles.font16WhiteBold,
                      ),
                      onPressed: () => context.toScreen(
                        screen: const EditPorductScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
