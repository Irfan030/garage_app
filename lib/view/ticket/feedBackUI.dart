import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/titleWidget.dart';

class FeedbackSection extends StatelessWidget {
  final Map<String, dynamic>? feedback;

  const FeedbackSection({super.key, this.feedback});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          val: "Service Rating",
          fontSize: 12,
          fontFamily: AppData.poppinsMedium,
          letterSpacing: 0,
          color: AppColor.blackText,
        ),

        SizedBox(height: getProportionateScreenHeight(8)),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < (feedback?["rating"] ?? 0)
                  ? Icons.star
                  : Icons.star_border,
              color: Colors.amber,
              size: 24,
            );
          }),
        ),
        SizedBox(height: getProportionateScreenHeight(16)),

        TitleWidget(
          val: "Comments",
          fontSize: 12,
          fontFamily: AppData.poppinsMedium,
          letterSpacing: 0,
          color: AppColor.blackText,
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: AppColor.containerBorderColor),
          ),
          child: Text(
            feedback?["comment"] ?? "",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "PoppinsRegular",
              color: AppColor.grayColor,
            ),
          ),
        ),
      ],
    );
  }
}
