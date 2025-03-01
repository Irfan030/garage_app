import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/titleWidget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  CustomAppBar({
    required this.title,
    this.backgroundColor = AppColor.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: SizeConfig.screenWidth,
      leading: Container(
        margin: EdgeInsets.only(left: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColor.whiteColor),
            ),
            TitleWidget(
              val: title,
              letterSpacing: 0,
              fontSize: 18,
              fontFamily: AppData.poppinsMedium,
              color: AppColor.whiteColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
