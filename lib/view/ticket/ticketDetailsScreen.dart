import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/titleWidget.dart';

class TicketDetailsScreen extends StatelessWidget {
  final Map<String, String> ticket;

  const TicketDetailsScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    const List<String> imageUrls = [
      'assets/images/tap_image1.png',
      'assets/images/tap_image2.png',
      'assets/images/tap_image1.png',
      'assets/images/tap_image2.png',
    ];

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(title: "Tickets"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle("Ticket Details"),

                GestureDetector(
                  onTap: () async {
                    Navigator.pushNamed(context, RoutePath.editTicket);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle(ticket["issue"]!),
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
                          val: ticket["status"]!,
                          fontSize: 10,
                          letterSpacing: 0,
                          fontFamily: AppData.poppinsRegular,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleWidget(
                        val: ticket["category"]!,
                        fontSize: 10,
                        letterSpacing: 0,
                        fontFamily: AppData.poppinsMedium,
                        color: AppColor.grayColor,
                      ),

                      TitleWidget(
                        val: "Ticket ID ${ticket["ticketId"]!}",
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
                          val: ticket["assessment"]!,
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
                            val: ticket["date"]!,
                            fontSize: 9,
                            letterSpacing: 0,
                            fontFamily: AppData.poppinsRegular,
                            color: AppColor.grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(14)),

                  _buildDetailRow("Category", ticket["mainCategory"]!),
                  _buildDetailRow("Sub Category", ticket["mainCategory"]!),
                  _buildPriorityRow("Priority (SLA)", ticket["priority"]!),
                  _buildDetailRow("Call Type", ticket["callType"]!),
                  _buildDetailRow("Equipment", ticket["equipment"]!),
                  _buildDetailRow("Component", ticket["component"]!),
                  _buildAssignedToRow("Assigned To", ticket["assignedTo"]!),
                  SizedBox(height: getProportionateScreenHeight(14)),

                  Wrap(
                    spacing: 5,
                    runSpacing: 8,
                    children:
                        imageUrls
                            .map(
                              (path) =>
                                  _buildStyledImage(context, path, imageUrls),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
            DefaultButton(press: () {}, text: "Download"),
            SizedBox(height: getProportionateScreenHeight(10)),

            DefaultButton(
              press: () {
                Navigator.pushNamed(
                  context,
                  RoutePath.escalateTicket,
                  arguments: ticket["ticketId"], // Pass the ticket ID
                );
              },
              text: "Escalate",
              backgroundColor: AppColor.whiteColor,
              textColor: AppColor.mainColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledImage(
    BuildContext context,
    String imagePath,
    List<String> thumbnails,
  ) {
    return GestureDetector(
      onTap: () {
        _showFullScreenImage(context, imagePath, thumbnails);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.blueColor, width: 1),
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          TitleWidget(
            val: "$label: ",
            color: AppColor.blackText,
            fontFamily: AppData.poppinsMedium,
            letterSpacing: 0,
            fontSize: 12,
          ),
          TitleWidget(
            val: value,

            color: AppColor.greyTextColor,
            fontFamily: AppData.poppinsRegular,
            letterSpacing: 0,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          TitleWidget(
            val: "$label: ",
            color: AppColor.blackText,
            fontFamily: AppData.poppinsMedium,
            letterSpacing: 0,
            fontSize: 12,
          ),
          TitleWidget(
            val: value,
            color: AppColor.pinkishOrangeColor,
            fontFamily: AppData.poppinsMedium,
            letterSpacing: 0,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedToRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          TitleWidget(
            val: "$label: ",
            color: AppColor.blackText,
            fontFamily: AppData.poppinsMedium,
            letterSpacing: 0,
            fontSize: 12,
          ),
          TitleWidget(
            val: value,
            color: AppColor.greenText,
            fontFamily: AppData.poppinsItalic,
            letterSpacing: 0,
            fontSize: 12,
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

  void _showFullScreenImage(
    BuildContext context,
    String imagePath,
    List<String> thumbnails,
  ) {
    showDialog(
      context: context,
      barrierColor: AppColor.blackColorWithOpacity75,
      builder: (BuildContext context) {
        String selectedImage = imagePath;

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.blackColorWithOpacity16,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: AppColor.blueColor, width: 1),
                    ),
                    child: Column(
                      children: [
                        // Main selected image (full view)
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: ClipRRect(
                            key: ValueKey<String>(selectedImage),
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              image: AssetImage(selectedImage),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Thumbnails with blue border highlight
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: thumbnails.length,
                            itemBuilder: (context, index) {
                              bool isSelected =
                                  thumbnails[index] == selectedImage;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImage = thumbnails[index];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? AppColor.blueColor
                                                : Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image(
                                        image: AssetImage(thumbnails[index]),
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),

                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: TitleWidget(
                      val: "Close",
                      fontSize: 12,
                      color: AppColor.whiteColor,
                      fontFamily: AppData.poppinsMedium,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
