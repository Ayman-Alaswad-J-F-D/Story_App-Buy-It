import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/app/functions/toast_snack_bar.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../app/extensions.dart';
import '../../../models/product_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_circular_progress.dart';
import '../../user_card_screen/user_card_screen.dart';

class AddToCardBottomSheet extends StatefulWidget {
  const AddToCardBottomSheet({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  State<AddToCardBottomSheet> createState() => _AddToCardBottomSheetState();
}

class _AddToCardBottomSheetState extends State<AddToCardBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        color: AppColors.secondPrimaryColor,
      ),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is InsertDatabaseState) {
            context.back();
            toastSnackBar(
              context: context,
              padding: 30,
              text:
                  "${AppCubit.get(context).quantity} quantity of this product has been added",
            );
          }
        },
        builder: (context, state) {
          final appCubit = AppCubit.get(context);
          if (appCubit.isInCard(idProduct: widget.product.id)) {
            return Row(
              children: [
                const Expanded(
                  child: Text(
                    "  Product already added",
                    style: TextStyles.font14YallowRegular,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    text: "Go To Card",
                    backgroundColor: AppColors.whiteColor,
                    colorText: AppColors.primaryColor,
                    duration: 3,
                    onTap: () =>
                        context.toScreen(screen: const UserCardScreen()),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.minus),
                  color: AppColors.whiteColor,
                  onPressed: () =>
                      setState(() => appCubit.decreaseQuantityProduct()),
                ),
                Text(
                  appCubit.quantity.toString().padLeft(2, '0'),
                  style: TextStyles.font17WhiteRegular,
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.plus),
                  color: AppColors.whiteColor,
                  onPressed: () => setState(
                    () => appCubit.increaseQuantityProduct(
                      context: context,
                      product: widget.product,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    duration: 1,
                    text: "Add To Card",
                    backgroundColor: AppColors.whiteColor,
                    colorText: AppColors.primaryColor,
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => const CustomCircularProgress(),
                      );
                      Future.delayed(
                        const Duration(milliseconds: 600),
                        () => appCubit.addToCard(product: widget.product),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
