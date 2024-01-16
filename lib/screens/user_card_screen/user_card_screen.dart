import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/cubit/app_cubit.dart';
import '../../theme/styles.dart';
import '../../widget/custom_animated_text.dart';
import '../../widget/custom_app_bar.dart';
import 'components/bill_header_widget.dart';
import 'components/total_price_widget.dart';
import 'components/user_bill_widget.dart';
import 'components/user_card_bottom_sheet.dart';

class UserCardScreen extends StatelessWidget {
  const UserCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      buildWhen: (previous, current) => current is DeleteDatabaseState,
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(textTitle: "Your Card", radius: Radius.zero),
          body: ConditionalBuilder(
            condition: cubit.cardUser.isNotEmpty,
            builder: (context) => Column(
              children: [
                const BillHeaderWidget(),
                UserBillWidget(cubit: cubit),
                const TotalPriceWidget(),
              ],
            ),
            fallback: (context) => const Center(
              child: CustomAnimatedText(
                animatedtext: "Please come back to add products",
                textStyle: TextStyles.pacifico16SecondPrimaryRegular,
              ),
            ),
          ),
          bottomSheet: UserCardBottomSheet(cubit: cubit),
        );
      },
    );
  }
}
