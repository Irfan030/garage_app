import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/titleWidget.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatefulWidget {
  final String title;
  final String subtitle;

  const SuccessScreen({super.key, required this.title, required this.subtitle});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Auto pop after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColorWithOpacity75,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/simple_tick.json',
              width: 100,
              height: 100,
              repeat: false,
            ),
            SizedBox(height: getProportionateScreenHeight(20)),

            TitleWidget(
              val: widget.title,
              letterSpacing: 0,
              fontSize: 16,
              fontFamily: AppData.poppinsSemiBold,
              color: AppColor.whiteColor,
            ),

            SizedBox(height: getProportionateScreenHeight(8)),

            TitleWidget(
              val: widget.subtitle,

              letterSpacing: 0,
              fontSize: 12,
              fontFamily: AppData.poppinsSemiBold,
              color: AppColor.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
