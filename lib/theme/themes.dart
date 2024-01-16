import 'package:flutter/material.dart';
import 'package:store_app/theme/colors.dart';

ThemeData themeLight = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: AppColors.secondPrimaryColor,
    primarySwatch: AppColors.primary,
  ),
  scaffoldBackgroundColor: AppColors.whiteColor,
  listTileTheme: const ListTileThemeData(iconColor: AppColors.grayColor),
  bottomSheetTheme: const BottomSheetThemeData(
    elevation: 0,
    backgroundColor: Colors.transparent,
  ),
);
