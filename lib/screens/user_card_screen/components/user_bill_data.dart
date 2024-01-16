import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';

class UserBillData extends StatelessWidget {
  const UserBillData({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.primaryColor,
      surfaceTintColor: AppColors.secondPrimaryColor,
      child: BlocBuilder<AppCubit, AppStates>(
        buildWhen: (previous, current) => current is UpdateDatabaseState,
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          final dataTime = DateTime.parse(cubit.cardUser[index].dataTime);
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "\$ ${cubit.totalPriceForProduct[index]}",
                    style: TextStyles.font16WhiteRegular,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${cubit.cardUser[index].quantity}",
                    style: TextStyles.font16WhiteRegular,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "${DateFormat.MMMEd().format(dataTime)}\n${DateFormat.Hms().format(dataTime)}",
                    textAlign: TextAlign.center,
                    style: TextStyles.font12WhiteRegular,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
