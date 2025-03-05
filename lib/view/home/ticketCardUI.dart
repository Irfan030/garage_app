import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/textButtonIcon.dart';
import 'package:garage_app/widget/titleWidget.dart';

class TicketCard extends StatelessWidget {
  final String issue;
  final String status;
  final String category;
  final String priority;
  final String ticketId;
  final String assessment;
  final String date;
  final String assignedTo;
  final VoidCallback onTap;

  const TicketCard({
    super.key,
    required this.issue,
    required this.status,
    required this.category,
    required this.priority,
    required this.ticketId,
    required this.assessment,
    required this.date,
    required this.assignedTo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColor.blueColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Issue and Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(
                  val: issue,
                  fontSize: 14,
                  letterSpacing: 0,
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
                    val: status,
                    fontSize: 10,
                    letterSpacing: 0,
                    fontFamily: AppData.poppinsRegular,
                    color: AppColor.whiteColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ), // Adjusted spacing
            // Category, Priority, and Ticket ID Row
            Row(
              children: [
                TitleWidget(
                  val: "$category • ",
                  fontSize: 10,
                  letterSpacing: 0,
                  fontFamily: AppData.poppinsMedium,
                  color: AppColor.grayColor,
                ),
                TitleWidget(
                  val: priority,
                  fontSize: 10,
                  letterSpacing: 0,
                  fontFamily: AppData.poppinsMedium,
                  color: AppColor.coralPinkColor,
                ),
                const Spacer(),
                TitleWidget(
                  val: "Ticket ID $ticketId",
                  fontSize: 9,
                  letterSpacing: 0,
                  fontFamily: AppData.poppinsMedium,
                  color: AppColor.greyTextColor,
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ), // Adjusted spacing
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
                    val: assessment,
                    fontSize: 12,
                    letterSpacing: 0,
                    fontFamily: AppData.poppinsRegular,
                    color: AppColor.blackText,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ), // Adjusted spacing
                  Align(
                    alignment: Alignment.centerRight,
                    child: TitleWidget(
                      val: date,
                      fontSize: 9,
                      letterSpacing: 0,
                      fontFamily: AppData.poppinsRegular,
                      color: AppColor.grayColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ), // Adjusted spacing
            // Assigned To and View Details Row
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
                        text: assignedTo,
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
                  onPressed: onTap,
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
