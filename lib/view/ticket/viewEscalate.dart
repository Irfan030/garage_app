import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/view/ticket/showReopenDialog.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/titleWidget.dart';

class ViewEscalationScreen extends StatelessWidget {
  final String ticketId;
  final String status;
  final String description;
  final String date;

  const ViewEscalationScreen({
    super.key,
    required this.ticketId,
    required this.status,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(title: "Tickets"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(
                  val: "Escalation Details",
                  fontSize: 14,
                  fontFamily: AppData.poppinsMedium,
                  color: AppColor.blackText,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(
                      context,
                      RoutePath.escalateTicket,
                      arguments: ticketId,
                    );
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/edit_icon.svg',
                        width: getProportionateScreenWidth(16.0),
                        height: getProportionateScreenHeight(16.0),
                      ),
                      SizedBox(width: getProportionateScreenWidth(4)),
                      TitleWidget(
                        val: "Edit",
                        fontFamily: AppData.poppinsRegular,
                        fontSize: 12,
                        color: AppColor.mainColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(15)),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ticket ID and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleWidget(
                        val: "Ticket ID $ticketId",

                        fontSize: 14,
                        fontFamily: AppData.poppinsMedium,
                        color: AppColor.blackText,
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              status == "Pending"
                                  ? AppColor.blueColor
                                  : AppColor.liteGreenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TitleWidget(
                          val: status,

                          fontSize: 10,
                          fontFamily: AppData.poppinsRegular,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(14)),
                  TitleWidget(
                    val: description,

                    fontSize: 12,
                    fontFamily: AppData.poppinsRegular,
                    color: AppColor.blackText,
                  ),

                  SizedBox(height: getProportionateScreenHeight(10)),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: TitleWidget(
                      val: date,

                      fontSize: 9,
                      fontFamily: AppData.poppinsRegular,
                      color: AppColor.grayColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(35)),

            DefaultButton(
              text: "Close Escalation",
              press: () {
                showConfirmationDialog(
                  context,
                  ticketId: "0001",
                  title: "Do you want to close the escalation?",
                  confirmButtonText: "Yes",
                  cancelButtonText: "No",
                  onConfirm: () {
                    Navigator.pop(context);

                    Navigator.pushReplacementNamed(
                      context,
                      RoutePath.successScreen,
                      arguments: {
                        'title': 'Escalation',
                        'subtitle': 'Closed successfully',
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: getProportionateScreenHeight(10)),

            DefaultButton(
              text: "Call Support",
              press: () {},
              backgroundColor: AppColor.whiteColor,
              textColor: AppColor.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
