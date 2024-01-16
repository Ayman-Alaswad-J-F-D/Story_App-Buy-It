import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/app/functions/toast_snack_bar.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/custom_snackbar.dart';

class LoginAnotherAccount extends StatelessWidget {
  const LoginAnotherAccount({Key? key}) : super(key: key);

  void toastSoon(context) => toastSnackBar(
        context: context,
        text: "Soon",
        backgroundColor: ToastStates.DONE,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            heroTag: "facebook",
            mini: true,
            onPressed: () => toastSoon(context),
            child: const Icon(
              FontAwesomeIcons.facebook,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        Flexible(
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            heroTag: "google",
            mini: true,
            onPressed: () => toastSoon(context),
            child: const Icon(
              FontAwesomeIcons.google,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        Flexible(
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            heroTag: "guest",
            mini: true,
            onPressed: () => toastSoon(context),
            child: const Icon(
              FontAwesomeIcons.userGroup,
              color: AppColors.whiteColor,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
