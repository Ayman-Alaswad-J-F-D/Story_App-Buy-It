import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../theme/colors.dart';
import '../../../widget/list_view_animation.dart';
import 'user_bill_data.dart';

class UserBillWidget extends StatelessWidget {
  const UserBillWidget({Key? key, required this.cubit}) : super(key: key);

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: cubit.cardUser.length,
          itemBuilder: (context, index) => ListViewAnimation(
            index: index,
            verticalOffset: 70,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    child: Text((index + 1).toString()),
                    backgroundColor: AppColors.secondPrimaryColor,
                    foregroundColor: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 8,
                  child: UserBillData(index: index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
