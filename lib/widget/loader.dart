import 'package:flutter/material.dart';
import 'package:garage_app/theme/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: AppColor.mainColor);
  }
}
