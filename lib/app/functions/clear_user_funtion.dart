import 'package:flutter/material.dart';

import '../../helper/local/cache_helper.dart';
import '../constants/constants.dart';
import '../cubit/app_cubit.dart';
import '../user_data/class_user_data.dart';

void clearUser(BuildContext context) {
  //* Clear user Data
  UserData.clearUserData();
  //* Clear cached user Data
  CacheHelper.removeData(key: "UserData");
  //* Clear token
  CacheHelper.removeData(key: "Token").then((_) => token = "");
  //* Clear favorite
  AppCubit.get(context).cachedFavorite.clear();
  //* Clear prodcuts from user card
  AppCubit.get(context).deleteProductsFromUserCard();
}
