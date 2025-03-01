import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/textButtonIcon.dart';
import 'package:garage_app/widget/titleWidget.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColor.blueColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(
                  val: "Power Issue",
                  letterSpacing: 0,

                  fontSize: 14,
                  fontFamily: AppData.poppinsMedium,
                  color: AppColor.blackText,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.blueColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TitleWidget(
                    letterSpacing: 0,
                    val: 'Pending',
                    fontSize: 10,
                    fontFamily: AppData.poppinsRegular,
                    color: AppColor.whiteColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(2)),
            Row(
              children: [
                TitleWidget(
                  val: "Pump •",
                  fontSize: 10,
                  letterSpacing: 0,

                  fontFamily: AppData.poppinsMedium,
                  color: AppColor.grayColor,
                ),
                TitleWidget(
                  val: "Urgent",
                  fontSize: 10,
                  letterSpacing: 0,

                  fontFamily: AppData.poppinsMedium,
                  color: AppColor.coralPinkColor,
                ),
                Spacer(),
                TitleWidget(
                  val: "Ticket ID 0001",
                  fontSize: 9,
                  letterSpacing: 0,
                  fontFamily: AppData.poppinsMedium,
                  color: AppColor.greyTextColor,
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            // Assessment Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.containerBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: AppColor.containerBorderColor,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  TitleWidget(
                    val: 'Pump Assessment',
                    fontSize: 12,
                    letterSpacing: 0,
                    fontFamily: AppData.poppinsRegular,
                    color: AppColor.blackText,
                  ),
                  SizedBox(height: getProportionateScreenHeight(3)),

                  Align(
                    alignment: Alignment.centerRight,

                    child: TitleWidget(
                      val: '30 Nov 2023',
                      fontSize: 9,
                      fontFamily: AppData.poppinsRegular,
                      letterSpacing: 0,

                      color: AppColor.grayColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: AppData.poppinsMedium,
                      color: AppColor.blackText,
                      letterSpacing: 0,
                    ),
                    children: [
                      const TextSpan(text: 'Assigned To: '),
                      TextSpan(
                        text: 'Yet to assigned',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.greenText,
                          fontFamily: AppData.poppinsItalic,
                        ),
                      ),
                    ],
                  ),
                ),
                TextIconButtonWidget(
                  text: 'View Details',
                  onPressed: () {},
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
