import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/theme/styles.dart';
import 'package:store_app/widget/custom_circular_progress.dart';

import '../../../app/constants/constants.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../theme/colors.dart';
import 'custom_container.dart';
import 'custom_icon.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 6),
      leading: Image.network(
        cubit.cardUser[widget.index].image,
        width: widthScreen(context) * 0.23,
        errorBuilder: (context, error, stackTrace) => SizedBox(
          width: widthScreen(context) * 0.23,
          child: const CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Quantity",
              style: TextStyles.font16PrimaryRegular,
            ),
            BlocBuilder<AppCubit, AppStates>(
              buildWhen: (previous, current) => current is UpdateDatabaseState,
              builder: (context, state) => Text(
                cubit.quantityHelper[widget.index].toString().padLeft(2, '0'),
                style: TextStyles.font18PrimaryRegular,
              ),
            ),
          ],
        ),
      ),
      subtitle: CustomContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIcon(
              icon: FontAwesomeIcons.minus,
              iconSize: 13,
              onPressed: () => setState(
                () => cubit.decreaseQuantityItem(index: widget.index),
              ),
            ),
            CustomIcon(
              icon: FontAwesomeIcons.plus,
              iconSize: 13,
              onPressed: () => setState(
                () => cubit.increaseQuantityItem(
                  index: widget.index,
                  context: context,
                ),
              ),
            ),
          ],
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            BlocBuilder<AppCubit, AppStates>(
              buildWhen: (previous, current) => current is UpdateDatabaseState,
              builder: (context, state) {
                final isUpdated = cubit.shouldShowUpdateConfirm(
                  index: widget.index,
                );
                return CustomIcon(
                  icon: FontAwesomeIcons.cartArrowDown,
                  color: isUpdated
                      ? AppColors.secondPrimaryColor
                      : AppColors.lightPrimaryColor,
                  onPressed:
                      isUpdated ? () => confirmQuantity(context, cubit) : null,
                );
              },
            ),
            CustomIcon(
              icon: Icons.delete,
              color: AppColors.iconLoveColor,
              onPressed: () => deleteProduct(context, cubit),
            ),
          ],
        ),
      ),
    );
  }

  void confirmQuantity(BuildContext context, AppCubit cubit) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomCircularProgress(),
    );
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => cubit.updateProductQuantityFromUserCard(index: widget.index),
    );
  }

  void deleteProduct(BuildContext context, AppCubit cubit) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomCircularProgress(),
    );
    await Future.delayed(
      const Duration(milliseconds: 400),
      () => cubit.deleteProductFromUserCard(index: widget.index),
    );
  }
}
