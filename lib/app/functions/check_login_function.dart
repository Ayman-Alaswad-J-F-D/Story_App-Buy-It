import 'package:flutter/material.dart';

import '../../helper/local/cache_helper.dart';
import '../../screens/auth/login_screen/login_screen.dart';
import '../../screens/products_screen/products_screen.dart';
import '../../screens/splash_screen/splash_screen.dart';
import '../constants/constants.dart';

Widget checkLogin() {
  final Widget startScreen;
  token = CacheHelper.getData(key: "Token");
  debugPrint("Token is : $token");
  if (token != null) {
    debugPrint("Products Screen");
    startScreen = const ProductsScreen();
  } else {
    debugPrint("Login Screen");
    startScreen = const LoginScreen();
  }
  return SplashScreen(startScreen: startScreen);
}
