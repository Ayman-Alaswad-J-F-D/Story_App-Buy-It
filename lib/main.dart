import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_app/app/injections_container/di.dart';

import 'app/cubit/app_cubit.dart';
import 'app/functions/check_login_function.dart';
import 'bloc_observer.dart';
import 'class_http_overrides.dart';
import 'screens/auth/cubit/auth_cubit.dart';
import 'theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModules();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = BlocObserverStoreApp();
  runApp(StoreApp(startScreen: checkLogin()));
}

class StoreApp extends StatelessWidget {
  const StoreApp({Key? key, required this.startScreen}) : super(key: key);

  final Widget startScreen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit()..authantication(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AppCubit()..initLocalDB(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        home: startScreen,
      ),
    );
  }
}
