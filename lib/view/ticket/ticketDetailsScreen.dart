import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/view/ticket/showReopenDialog.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/textbutton.dart';
import 'package:garage_app/widget/titleWidget.dart';

import 'feedbackDialog.dart';

class TicketDetailsScreen extends StatefulWidget {
  final Map<String, String> ticket;

  const TicketDetailsScreen({super.key, required this.ticket});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  bool hasEscalation = false;

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

                widget.ticket["status"] == "Open"
                    ? GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(
                          context,
                          RoutePath.editTicket,
                          arguments: {'isEditMode': true},
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
                    )
                    : TextButtonWidget(
                      text: "Reopen",
                      fontSize: 12,
                      fontFamily: AppData.poppinsRegular,
                      letterSpacing: 0,
                      onPressed: () {
                        showConfirmationDialog(
                          context,
                          ticketId: widget.ticket["ticketId"]!,
                          title: "Do you want to reopen this ticket?",
                          confirmButtonText: "Reopen",
                          cancelButtonText: "Cancel",
                          onConfirm: () {
                            Navigator.pop(context);
                          },
                        );
                      },
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
                      _buildSectionTitle(widget.ticket["issue"]!),
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
                          val: widget.ticket["status"]!,
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
                        val: widget.ticket["category"]!,
                        fontSize: 10,
                        letterSpacing: 0,
                        fontFamily: AppData.poppinsMedium,
                        color: AppColor.grayColor,
                      ),

                      TitleWidget(
                        val: "Ticket ID ${widget.ticket["ticketId"]!}",
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
                          val: widget.ticket["assessment"]!,
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
                            val: widget.ticket["date"]!,
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

                  _buildDetailRow("Category", widget.ticket["mainCategory"]!),
                  _buildDetailRow(
                    "Sub Category",
                    widget.ticket["mainCategory"]!,
                  ),
                  _buildPriorityRow(
                    "Priority (SLA)",
                    widget.ticket["priority"]!,
                  ),
                  _buildDetailRow("Call Type", widget.ticket["callType"]!),
                  _buildDetailRow("Equipment", widget.ticket["equipment"]!),
                  _buildDetailRow("Component", widget.ticket["component"]!),
                  _buildAssignedToRow(
                    "Assigned To",
                    widget.ticket["assignedTo"]!,
                  ),
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

                  if (widget.ticket["status"] == "Completed")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        SizedBox(height: getProportionateScreenHeight(25)),

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
                                val: widget.ticket["assessmentClosed"]!,
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
                                  val: widget.ticket["date"]!,
                                  fontSize: 9,
                                  letterSpacing: 0,
                                  fontFamily: AppData.poppinsRegular,
                                  color: AppColor.grayColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        Wrap(
                          spacing: 5,
                          runSpacing: 8,
                          children:
                              imageUrls
                                  .map(
                                    (path) => _buildStyledImage(
                                      context,
                                      path,
                                      imageUrls,
                                    ),
                                  )
                                  .toList(),
                        ),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        Divider(
                          thickness: 1,
                          color: AppColor.containerBorderColor,
                        ),
                        SizedBox(height: getProportionateScreenHeight(12)),
                        Center(
                          child: TextButtonWidget(
                            text: "Submit Feedback",
                            fontSize: 12,
                            fontFamily: AppData.poppinsRegular,
                            letterSpacing: 0,
                            textAlign: TextAlign.center,
                            onPressed: () {
                              FeedbackDialog.showFeedbackDialog(context);
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(25)),

            DefaultButton(press: () {}, text: "Download"),
            SizedBox(height: getProportionateScreenHeight(10)),

            // Visibility(
            //   visible: ticket["status"] == "Open",
            //   child: DefaultButton(
            //     press: () {
            //       Navigator.pushNamed(
            //         context,
            //         RoutePath.escalateTicket,
            //         arguments: ticket["ticketId"],
            //       );
            //     },
            //     text: "Escalate",
            //     backgroundColor: AppColor.whiteColor,
            //     textColor: AppColor.mainColor,
            //   ),
            // ),
            Visibility(
              visible: widget.ticket["status"] == "Open",
              child: DefaultButton(
                press: () {
                  if (hasEscalation) {
                    Navigator.pushNamed(
                      context,
                      RoutePath.viewEscalation,
                      arguments: {
                        "ticketId": widget.ticket["ticketId"],
                        "status": "Pending",
                        "description":
                            "Technician has been assigned 2 days ago, but the issue is yet to be addressed by the assigned technician.",
                        "date": "02 Dec 2023",
                      },
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      RoutePath.escalateTicket,
                      arguments: widget.ticket["ticketId"],
                    ).then((result) {
                      if (result == true) {
                        setState(() {
                          hasEscalation = true;
                        });
                      }
                    });
                  }
                },
                text: hasEscalation ? "View Escalation" : "Escalate",
                backgroundColor: AppColor.whiteColor,
                textColor: AppColor.mainColor,
              ),
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
