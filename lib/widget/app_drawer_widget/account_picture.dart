import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/constants/strings.dart';
import 'package:store_app/screens/auth/cubit/auth_cubit.dart';
import 'package:store_app/theme/colors.dart';
import 'package:store_app/widget/app_drawer_widget/class_user_data_helper.dart';
import 'package:store_app/widget/app_drawer_widget/show_image_source.dart';

class AccountPicture extends StatelessWidget {
  const AccountPicture({Key? key}) : super(key: key);

  ImageProvider<Object> checkImage(context) {
    final cubit = AuthCubit.get(context);
    if (cubit.photoFromGallery.path != "") {
      return FileImage(cubit.photoFromGallery);
    }
    return NetworkImage(UserDataHelper.image);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final profilePicture = checkImage(context);
            return Container(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightPrimaryColor,
                border: Border.all(color: AppColors.whiteColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grayColor.withOpacity(.7),
                    blurRadius: 2,
                    spreadRadius: 1.5,
                  )
                ],
              ),
              child: Image(
                image: profilePicture,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppColors.whiteColor,
                        value: loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 0),
                      ),
                    );
                  }
                  return child;
                },
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset(avatarImage),
              ),
            );
          },
        ),
        Positioned(
          left: 52,
          bottom: 52,
          child: CircleAvatar(
            backgroundColor: AppColors.secondPrimaryColor,
            radius: 10,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.edit,
                size: 12,
                color: AppColors.whiteColor,
              ),
              onPressed: () => showImageSource(context),
            ),
          ),
        ),
      ],
    );
  }
}
