import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/titleWidget.dart';

class TicketDetailsScreen extends StatelessWidget {
  final Map<String, String> ticket;

  const TicketDetailsScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Tickets"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle("Ticket Details"),

                GestureDetector(
                  onTap: () {},
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
                        fontFamily: AppData.openSansMedium,
                        fontSize: 13,
                        color: AppColor.mainColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColor.blueColor, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket["issue"]!,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppData.poppinsMedium,
                      color: AppColor.blackText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow("Category", ticket["category"]!),
                  _buildDetailRow(
                    "Sub Category",
                    ticket["subCategory"] ?? "N/A",
                  ),
                  _buildDetailRow("Priority", ticket["priority"]!),
                  _buildDetailRow("Assigned To", ticket["assignedTo"]!),
                  _buildDetailRow("Equipment", ticket["equipment"] ?? "N/A"),
                  _buildDetailRow("Component", ticket["component"] ?? "N/A"),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppData.poppinsMedium,
              color: AppColor.grayColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppData.poppinsRegular,
              color: AppColor.blackText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return TitleWidget(
      val: title,
      color: AppColor.blackText,
      fontFamily: AppData.poppinsMedium,
      letterSpacing: 0,
      fontSize: 14,
    );
  }
}
