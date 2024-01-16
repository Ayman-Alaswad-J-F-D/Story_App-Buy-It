import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/cubit/app_cubit.dart';
import '../../app/extensions.dart';
import '../../app/functions/toast_snack_bar.dart';
import '../../theme/colors.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_snackbar.dart';
import '../../widget/fall_back_connection_widget.dart';
import '../../widget/list_view_animation.dart';
import 'components/custom_list_tile.dart';

class EditPorductScreen extends StatelessWidget {
  const EditPorductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(textTitle: "Edit Product"),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is DeleteDatabaseState) {
            context.back();
            toastSnackBar(
              context: context,
              text: "The product has been deleted from your card",
              backgroundColor: ToastStates.ERROR,
            );
          }
          if (state is UpdateDatabaseState) {
            context.back();
            toastSnackBar(
              context: context,
              text: "The product quantity has been adjusted",
              backgroundColor: ToastStates.DONE,
            );
          }
        },
        buildWhen: (previous, current) => current is DeleteDatabaseState,
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.cardUser.isNotEmpty,
            builder: (context) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: cubit.cardUser.length,
                itemBuilder: (context, index) => ListViewAnimation(
                  index: index,
                  child: Card(
                    color: AppColors.secondPrimaryColor,
                    surfaceTintColor: AppColors.secondPrimaryColor,
                    child: Card(
                      key: Key(index.toString()),
                      elevation: 2,
                      color: AppColors.whiteColor,
                      surfaceTintColor: AppColors.whiteColor,
                      child: CustomListTile(index: index),
                    ),
                  ),
                ),
              );
            },
            fallback: (BuildContext context) => const FallBackWidget(
              text: "Please come back to add products",
              colorText: AppColors.yallowColor,
            ),
          );
        },
      ),
    );
  }
}
