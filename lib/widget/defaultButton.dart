import 'package:flutter/material.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  const DefaultButton({
    super.key,
    required this.text,
    required this.press,
    this.backgroundColor = AppColor.mainColor,
    this.textColor = AppColor.whiteColor,
    this.borderRadius = 23,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        press();
      },
      child: Container(
        height: getProportionateScreenHeight(45),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontFamily: "PoppinsMedium",
            ),
          ),
        ),
      ),
    );
  }
}
