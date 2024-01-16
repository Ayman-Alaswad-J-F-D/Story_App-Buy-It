import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/constants/strings.dart';
import '../../widget/fade_route_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.startScreen}) : super(key: key);
  final Widget startScreen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.pushReplacement(
        context,
        FadeRouteAnimation(page: widget.startScreen),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(iconAppImage, scale: 3),
      ),
    );
  }
}
