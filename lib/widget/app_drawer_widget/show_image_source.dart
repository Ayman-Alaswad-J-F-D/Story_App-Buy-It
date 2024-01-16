import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/screens/auth/cubit/auth_cubit.dart';

import '../../app/extensions.dart';
import '../../theme/colors.dart';
import '../../theme/styles.dart';

showImageSource(BuildContext context) {
  return showDialog(
    barrierColor: Colors.black38,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
      title: const Text(
        "Choice Way",
        style: TextStyles.pacifico16SecondPrimaryRegular,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.image_outlined,
              color: AppColors.primaryColor,
            ),
            title: const Text(
              "Gallery",
              style: TextStyles.font14PrimaryRegular,
            ),
            onTap: () =>
                AuthCubit.get(context).pickPhoto().then((_) => context.back()),
          ),
          ListTile(
            leading: const Icon(
              Icons.camera_alt_outlined,
              color: AppColors.primaryColor,
            ),
            title: const Text(
              "Camera",
              style: TextStyles.font14PrimaryRegular,
            ),
            onTap: () => AuthCubit.get(context)
                .pickPhoto(imageSource: ImageSource.camera)
                .then((_) => context.back()),
          ),
        ],
      ),
    ),
  );
}
