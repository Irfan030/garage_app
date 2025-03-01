import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/widget/titleWidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RoutePath.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.mainColor.withOpacity(0.1),
      ),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: AppColor.whiteColor,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/splash.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Center(child: TitleWidget(val: "Welcome Back")),
          ),
        ),
      ),
    );
  }
}
